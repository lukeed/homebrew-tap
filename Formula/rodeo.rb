class Rodeo < Formula
  desc "Keyboard-first terminal UI for herdr-core, sharing panes with the Herdr app"
  homepage "https://rodeo.lukeed.com"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://rodeo.lukeed.com/download/v0.1.1/rodeo-aarch64-apple-darwin.tar.gz"
      sha256 "b824f67b7e6475a27fb9853cf32dee72cd62c3bae04c916ae04228ae03fe3e98"
    end
    on_intel do
      url "https://rodeo.lukeed.com/download/v0.1.1/rodeo-x86_64-apple-darwin.tar.gz"
      sha256 "24e586fca10468e65843c99d16f5796970e7f558ca74e7e28192098336814217"
    end
  end

  on_linux do
    on_arm do
      url "https://rodeo.lukeed.com/download/v0.1.1/rodeo-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6c8fe63b6b99ee1cf2a4f747d4daf9b3a159c786aa4ddadec3f89d46c5d26abd"
    end
    on_intel do
      url "https://rodeo.lukeed.com/download/v0.1.1/rodeo-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7a2b3ff1c4b2a52cb4c76eadc54e77a971d7e020e8fdf3096c58a857f9e49038"
    end
  end

  def install
    bin.install "rodeo"
  end

  def caveats
    <<~EOS
      rodeo needs hc (herdr-core) 0.1.18 or newer on your PATH.
      Homebrew does not ship it. Install it with:
        curl -fsSL https://releases.herdr.dev/core/install.sh | sh
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rodeo --version")
  end
end
