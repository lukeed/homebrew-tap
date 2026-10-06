class Pocketty < Formula
  desc "Host daemon for the pocketty iOS terminal: agent alerts and phone setup"
  homepage "https://pocketty.app"

  on_macos do
    on_arm do
      url "https://dl.pocketty.app/0.1.2/pocketty-aarch64-apple-darwin.tar.gz"
      sha256 "a7635c04dc50d978e52d13c1f243eedce0c541427c98ac7d88456396ea3e7917"
    end
    on_intel do
      url "https://dl.pocketty.app/0.1.2/pocketty-x86_64-apple-darwin.tar.gz"
      sha256 "06f4f1874b66c9a3303240ce728e557fedfaa74f9c12cfef6964e0697399803f"
    end
  end

  on_linux do
    on_arm do
      url "https://dl.pocketty.app/0.1.2/pocketty-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d8fe4a97fc3ea3d04647d4425889d6b1f9ff694d29ab6d54d45943fb98e44fae"
    end
    on_intel do
      url "https://dl.pocketty.app/0.1.2/pocketty-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1caeae38322614df0a66cd42fa1ec9328879e52495e7f5c482c786bda8f12055"
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
