class Rodeo < Formula
  desc "Keyboard-first terminal UI for herdr-core, sharing panes with the Herdr app"
  homepage "https://rodeo.lukeed.com"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://rodeo.lukeed.com/download/v0.1.0/rodeo-aarch64-apple-darwin.tar.gz"
      sha256 "38c0a2886c3e904977221a88dad8b7f08e195b3a76c1755fc4380e8be8f3a66c"
    end
    on_intel do
      url "https://rodeo.lukeed.com/download/v0.1.0/rodeo-x86_64-apple-darwin.tar.gz"
      sha256 "e6f6b9a197f645df41f84a51697e9baf4bca3e1ffeceb191831fbdaaac4d6794"
    end
  end

  on_linux do
    on_arm do
      url "https://rodeo.lukeed.com/download/v0.1.0/rodeo-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7bfa55689f748bb3c67998d27485c362ef968867681d158ce925bed70ce8435e"
    end
    on_intel do
      url "https://rodeo.lukeed.com/download/v0.1.0/rodeo-x86_64-unknown-linux-musl.tar.gz"
      sha256 "50355d2fb12cb233fc3e7857c2860682541f8ffcdbd620d92c746f892887b67c"
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
