class Rodeo < Formula
  desc "Keyboard-first terminal UI for herdr-core, sharing panes with the Herdr app"
  homepage "https://rodeo.lukeed.com"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://rodeo.lukeed.com/download/v0.2.1/rodeo-aarch64-apple-darwin.tar.gz"
      sha256 "e0ca47cc3c3af5232eeca6ec7869bea44e354601f3f05e5dfc1f5fac0cf65e8c"
    end
    on_intel do
      url "https://rodeo.lukeed.com/download/v0.2.1/rodeo-x86_64-apple-darwin.tar.gz"
      sha256 "14825ada3e6fc3cf3eb04094f8df8855f461fc5b74ed4c0461d1f36662faa263"
    end
  end

  on_linux do
    on_arm do
      url "https://rodeo.lukeed.com/download/v0.2.1/rodeo-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4a5f65b5c9729a0aca9e5f81d4b569df6e2831b6417b61365576b2511f00e983"
    end
    on_intel do
      url "https://rodeo.lukeed.com/download/v0.2.1/rodeo-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d2beeee95096e0df1ff70e416e3218f9787ca250bc866ba71c01ffc81c5835ca"
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
