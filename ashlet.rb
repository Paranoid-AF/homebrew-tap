class Ashlet < Formula
  desc "AI-powered shell auto-completion for Zsh"
  homepage "https://github.com/Paranoid-AF/ashlet"
  version "0.1.3"

  depends_on "socat"
  depends_on "jq"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Paranoid-AF/ashlet/releases/download/v#{version}/ashlet-darwin-amd64.tar.gz"
      sha256 "3b59a70a39008a2dc4a6928b90304a305217fc226f753165aecfcf601b727d47"

      def install
        bin.install "ashletd"
        (share/"ashlet").install Dir["shell/*"]
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/Paranoid-AF/ashlet/releases/download/v#{version}/ashlet-darwin-arm64.tar.gz"
      sha256 "588b9963ba892a34a33f5c327c4efb13f29a17f29c31ddbf4991e807104a0e0a"

      def install
        bin.install "ashletd"
        (share/"ashlet").install Dir["shell/*"]
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Paranoid-AF/ashlet/releases/download/v#{version}/ashlet-linux-amd64.tar.gz"
      sha256 "ac423f1f3ce5760c76369cc33596833187e8f3365f97d9c66da08ef85405e1ea"

      def install
        bin.install "ashletd"
        (share/"ashlet").install Dir["shell/*"]
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Paranoid-AF/ashlet/releases/download/v#{version}/ashlet-linux-arm64.tar.gz"
      sha256 "0fa2622df2ddbc7f34de4ca675a437f2ea29633a689e76f74d59f69f9df0efca"

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
