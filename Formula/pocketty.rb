class Pocketty < Formula
  desc "Host daemon for the pocketty iOS terminal: agent alerts and phone setup"
  homepage "https://pocketty.app"

  on_macos do
    on_arm do
      url "https://dl.pocketty.app/0.1.1/pocketty-aarch64-apple-darwin.tar.gz"
      sha256 "87dbbb8588185d65113ff35fc5fd46255fea7450fb6eaab2e4309df5e3513b8f"
    end
    on_intel do
      url "https://dl.pocketty.app/0.1.1/pocketty-x86_64-apple-darwin.tar.gz"
      sha256 "8a257cdb01eaa9fc8ddfd9c5d9be5bcb7bdf39c07f16e408c563c2ba86563b40"
    end
  end

  on_linux do
    on_arm do
      url "https://dl.pocketty.app/0.1.1/pocketty-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9d2c230a4696d77d21beaf662a887f053264e4733f875ca120bb64ddb6fd162a"
    end
    on_intel do
      url "https://dl.pocketty.app/0.1.1/pocketty-x86_64-unknown-linux-musl.tar.gz"
      sha256 "269544533c8f5053b49babb72bca64781606255ac3605a468c104393a01c9edb"
    end
  end

  def install
    bin.install "pocketty"
  end

  def caveats
    <<~EOS
      Install pocketty with Homebrew or with the install script, not both.
      If you used the script before, remove that copy first:
        curl -fsSL https://pocketty.app/install.sh | sh -s -- --uninstall
    EOS
  end

  service do
    run [opt_bin/"pocketty", "daemon"]
    keep_alive true
    log_path var/"log/pocketty.log"
    error_log_path var/"log/pocketty.log"
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pocketty --version")
  end
end
