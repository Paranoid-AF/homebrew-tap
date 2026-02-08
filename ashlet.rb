class Ashlet < Formula
  desc "AI-powered shell auto-completion for Zsh"
  homepage "https://github.com/Paranoid-AF/ashlet"
  version "0.1.4"

  depends_on "socat"
  depends_on "jq"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Paranoid-AF/ashlet/releases/download/v#{version}/ashlet-darwin-amd64.tar.gz"
      sha256 "52c808650031deea5d184c53906057b195e69df827f0b82e8eb19016fca36763"

      def install
        bin.install "ashletd"
        (share/"ashlet").install Dir["shell/*"]
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/Paranoid-AF/ashlet/releases/download/v#{version}/ashlet-darwin-arm64.tar.gz"
      sha256 "c840915d6f30dc881f2d7b69b72a54f3eb2cbf854565118f10561c0de06626b3"

      def install
        bin.install "ashletd"
        (share/"ashlet").install Dir["shell/*"]
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Paranoid-AF/ashlet/releases/download/v#{version}/ashlet-linux-amd64.tar.gz"
      sha256 "f4c3163bb4df13e750ffdff4206d312d7e0369546ea659affadde0742bcf91d7"

      def install
        bin.install "ashletd"
        (share/"ashlet").install Dir["shell/*"]
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Paranoid-AF/ashlet/releases/download/v#{version}/ashlet-linux-arm64.tar.gz"
      sha256 "73e26f790ccf4d6a4beedbd879667adc662d9e0d80fca3e545e0693f6d96e516"

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
