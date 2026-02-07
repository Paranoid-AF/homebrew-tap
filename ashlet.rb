class Ashlet < Formula
  desc "AI-powered shell auto-completion for Zsh"
  homepage "https://github.com/Paranoid-AF/ashlet"
  version "0.1.2"

  depends_on "socat"
  depends_on "jq"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Paranoid-AF/ashlet/releases/download/v#{version}/ashlet-darwin-amd64.tar.gz"
      sha256 "9ee677b9610e54fe2dd21b59ec5ef97a5b62b9f6d3e0ffe5acd570c20a298906"

      def install
        bin.install "ashletd"
        (share/"ashlet").install Dir["shell/*"]
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/Paranoid-AF/ashlet/releases/download/v#{version}/ashlet-darwin-arm64.tar.gz"
      sha256 "abaa221d6a1f4ff0a65eb0e5f490516f9893df9bfec7ab0ea1c32d83e5931391"

      def install
        bin.install "ashletd"
        (share/"ashlet").install Dir["shell/*"]
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Paranoid-AF/ashlet/releases/download/v#{version}/ashlet-linux-amd64.tar.gz"
      sha256 "2a388dc65716ff9ab969ded91e96677367efa94e86e67f1a9e76c00354b8643d"

      def install
        bin.install "ashletd"
        (share/"ashlet").install Dir["shell/*"]
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Paranoid-AF/ashlet/releases/download/v#{version}/ashlet-linux-arm64.tar.gz"
      sha256 "0c1448508bc97f81d90106edc952f5f70e2ac1683e378a7b1f3fa228b4ad9b9b"

      def install
        bin.install "ashletd"
        (share/"ashlet").install Dir["shell/*"]
      end
    end
  end

  service do
    run [opt_bin/"ashletd"]
    keep_alive true
    log_path var/"log/ashlet.log"
    error_log_path var/"log/ashlet.log"
  end

  def caveats
    <<~EOS
      🐚 To enable ashlet, add this to your ~/.zshrc:

        source #{opt_share}/ashlet/ashlet.zsh

      🚀 To start the daemon (runs automatically on login):

        brew services start ashlet
    EOS
  end
end
