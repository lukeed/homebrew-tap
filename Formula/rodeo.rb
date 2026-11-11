class Rodeo < Formula
  desc "Keyboard-first terminal UI for herdr-core, sharing panes with the Herdr app"
  homepage "https://rodeo.lukeed.com"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://rodeo.lukeed.com/download/v0.2.0/rodeo-aarch64-apple-darwin.tar.gz"
      sha256 "01daa26ff46d562da424e61457a7f9c2a9fe6b38f63b519b3dffc12ae7d28989"
    end
    on_intel do
      url "https://rodeo.lukeed.com/download/v0.2.0/rodeo-x86_64-apple-darwin.tar.gz"
      sha256 "2472b34ce4e4166a49e3be85cd1f91fa8bde88456db7d214501114926bd56f65"
    end
  end

  on_linux do
    on_arm do
      url "https://rodeo.lukeed.com/download/v0.2.0/rodeo-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5d8cb4544beafe74a1432abca37178fca90ade16adc74fbaec13f7fdc8af1867"
    end
    on_intel do
      url "https://rodeo.lukeed.com/download/v0.2.0/rodeo-x86_64-unknown-linux-musl.tar.gz"
      sha256 "68544d52769ad1d8ef94d03ba44cf465690590ea0b661f795c819ce11513790f"
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
