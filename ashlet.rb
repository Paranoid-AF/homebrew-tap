class Ashlet < Formula
  desc "AI-powered shell auto-completion for Zsh"
  homepage "https://github.com/Paranoid-AF/ashlet"
  version "0.2.0"

  depends_on "socat"
  depends_on "jq"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Paranoid-AF/ashlet/releases/download/v#{version}/ashlet-darwin-amd64.tar.gz"
      sha256 "891455044f95aa4b1c907c7e75f71f68d52d1654a8b7a9af6f302a3db389ea92"

      def install
        bin.install "ashletd"
        (share/"ashlet").install Dir["shell/*"]
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/Paranoid-AF/ashlet/releases/download/v#{version}/ashlet-darwin-arm64.tar.gz"
      sha256 "2e1426ae7bd6a8e125d3cc51c41417f9844f7cbe7f5b28489aeb0acd3354c60f"

      def install
        bin.install "ashletd"
        (share/"ashlet").install Dir["shell/*"]
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Paranoid-AF/ashlet/releases/download/v#{version}/ashlet-linux-amd64.tar.gz"
      sha256 "d51bcfdf1803bef727075410d4d39970be512569543838b7bdad97cf23c4d024"

      def install
        bin.install "ashletd"
        (share/"ashlet").install Dir["shell/*"]
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Paranoid-AF/ashlet/releases/download/v#{version}/ashlet-linux-arm64.tar.gz"
      sha256 "b9cd01cb935760a55ed588ca2c6c0ad966bb664e54e021938a98a46f64c0e237"

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
