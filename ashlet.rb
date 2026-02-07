class Ashlet < Formula
  desc "AI-powered shell auto-completion for Zsh"
  homepage "https://github.com/Paranoid-AF/ashlet"
  version "0.1.0"

  depends_on "socat"
  depends_on "jq"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Paranoid-AF/ashlet/releases/download/v#{version}/ashlet-darwin-amd64.tar.gz"
      sha256 "PLACEHOLDER_DARWIN_AMD64"

      def install
        bin.install "ashletd"
        (share/"ashlet").install Dir["shell/*"]
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/Paranoid-AF/ashlet/releases/download/v#{version}/ashlet-darwin-arm64.tar.gz"
      sha256 "PLACEHOLDER_DARWIN_ARM64"

      def install
        bin.install "ashletd"
        (share/"ashlet").install Dir["shell/*"]
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Paranoid-AF/ashlet/releases/download/v#{version}/ashlet-linux-amd64.tar.gz"
      sha256 "PLACEHOLDER_LINUX_AMD64"

      def install
        bin.install "ashletd"
        (share/"ashlet").install Dir["shell/*"]
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Paranoid-AF/ashlet/releases/download/v#{version}/ashlet-linux-arm64.tar.gz"
      sha256 "PLACEHOLDER_LINUX_ARM64"

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
      To enable ashlet, add this to your ~/.zshrc:

        source #{opt_share}/ashlet/ashlet.zsh

      To start the daemon (runs automatically on login):

        brew services start ashlet
    EOS
  end
end
