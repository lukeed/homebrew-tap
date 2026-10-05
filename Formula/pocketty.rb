class Pocketty < Formula
  desc "Host daemon for the pocketty iOS terminal: agent alerts and phone setup"
  homepage "https://pocketty.app"

  on_macos do
    on_arm do
      url "https://dl.pocketty.app/0.1.0/pocketty-aarch64-apple-darwin.tar.gz"
      sha256 "b40f55923713b78b4978111942c9deb6726a310a23ea331b40c35545d0600ecc"
    end
    on_intel do
      url "https://dl.pocketty.app/0.1.0/pocketty-x86_64-apple-darwin.tar.gz"
      sha256 "41e8e02370eada4b459f3b1c4bef6487c12565532bdab52ea0e7d3eb685cf8bd"
    end
  end

  on_linux do
    on_arm do
      url "https://dl.pocketty.app/0.1.0/pocketty-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1866bbd48f941771526fdf7c23323b70d3828b962f7c2cfb3ffe452c6601dd4d"
    end
    on_intel do
      url "https://dl.pocketty.app/0.1.0/pocketty-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2915bf0bea2288c0287869d4ba1b08328ddba6ce87cb7ac6aabc39d1720549e3"
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
