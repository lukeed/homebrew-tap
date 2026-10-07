class Pocketty < Formula
  desc "Host daemon for the pocketty iOS terminal: agent alerts and phone setup"
  homepage "https://pocketty.app"

  on_macos do
    on_arm do
      url "https://dl.pocketty.app/0.1.3/pocketty-aarch64-apple-darwin.tar.gz"
      sha256 "8c8c91a84004dfd98241d3ab7753746735ac7442fe1e06822f074a8c3be57211"
    end
    on_intel do
      url "https://dl.pocketty.app/0.1.3/pocketty-x86_64-apple-darwin.tar.gz"
      sha256 "2c1e1339713c166490d4cbd2c50314e06b9cb9135af65e46fdc1995476239258"
    end
  end

  on_linux do
    on_arm do
      url "https://dl.pocketty.app/0.1.3/pocketty-aarch64-unknown-linux-musl.tar.gz"
      sha256 "77af5f490d4533d98e74f5082d74c1d8abd21648e72e50df98ccf0e7a839671e"
    end
    on_intel do
      url "https://dl.pocketty.app/0.1.3/pocketty-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8e6a95b9c45c94a8f894144a4f446a21a9e59f0cc2f8f49ed42852f4b4426cfc"
    end
  end

  def install
    if OS.mac?
      prefix.install "pocketty.app"
      bin.install_symlink prefix/"pocketty.app/Contents/MacOS/pocketty"
      (prefix/"#{plist_name}.plist").write <<~PLIST
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>AssociatedBundleIdentifiers</key>
          <string>app.pocketty.daemon</string>
          <key>ProgramArguments</key>
          <array>
            <string>#{opt_prefix}/pocketty.app/Contents/MacOS/pocketty</string>
            <string>daemon</string>
          </array>
          <key>EnvironmentVariables</key>
          <dict>
            <key>PATH</key>
            <string>#{HOMEBREW_PREFIX}/bin:#{HOMEBREW_PREFIX}/sbin:/usr/bin:/bin:/usr/sbin:/sbin</string>
          </dict>
          <key>RunAtLoad</key>
          <true/>
          <key>KeepAlive</key>
          <true/>
          <key>StandardOutPath</key>
          <string>#{var}/log/pocketty.log</string>
          <key>StandardErrorPath</key>
          <string>#{var}/log/pocketty.log</string>
          <key>LimitLoadToSessionType</key>
          <array>
            <string>Aqua</string>
            <string>Background</string>
            <string>LoginWindow</string>
            <string>StandardIO</string>
            <string>System</string>
          </array>
        </dict>
        </plist>
      PLIST
    else
      bin.install "pocketty"
    end
  end

  def caveats
    <<~EOS
      Install pocketty with Homebrew or with the install script, not both.
      If you used the script before, remove that copy first:
        curl -fsSL https://pocketty.app/install.sh | sh -s -- --uninstall
    EOS
  end

  service do
    # brew cannot write AssociatedBundleIdentifiers, so macOS uses the plist from install
    run linux: [opt_bin/"pocketty", "daemon"]
    keep_alive true
    log_path var/"log/pocketty.log"
    error_log_path var/"log/pocketty.log"
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pocketty --version")
  end
end
