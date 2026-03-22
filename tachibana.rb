class Tachibana < Formula
  desc "Multi-platform iOS device manipulation suite"
  homepage "https://github.com/Paranoid-AF/tachibana"
  version "0.0.1"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Paranoid-AF/tachibana/releases/download/v0.0.1/tachibana-darwin-arm64.tar.gz"
      sha256 "ca7baffeb682ea45a56b1fb7e86ec49290fff8fd2797b0609a74d2347377d68e"
    else
      url "https://github.com/Paranoid-AF/tachibana/releases/download/v0.0.1/tachibana-darwin-x64.tar.gz"
      sha256 "7991fb8848133209ccd907875ed8859982e3537bb461a546c7944ade05c5e3c8"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"tachibana"
  end

  test do
    assert_match "tachibana", shell_output("#{bin}/tachibana --help 2>&1", 1)
  end
end
