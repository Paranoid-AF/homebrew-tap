class Tachibana < Formula
  desc "Multi-platform iOS device manipulation suite"
  homepage "https://github.com/Paranoid-AF/tachibana"
  version "0.0.1-dev.2"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Paranoid-AF/tachibana/releases/download/v0.0.1-dev.2/tachibana-darwin-arm64.tar.gz"
      sha256 "63152c39e052f400a2d9e63c18ee0b38925f16dd79fd94c7b7ac7ad0978b93b2"
    else
      url "https://github.com/Paranoid-AF/tachibana/releases/download/v0.0.1-dev.2/tachibana-darwin-x64.tar.gz"
      sha256 "6b9e19f545cb0186798eb3764d8003a60c34c16746d0bc5ec93dbd63179f5151"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"tachibana"
  end

  service do
    run [opt_libexec/"tachibana"]
    working_dir opt_libexec
    keep_alive true
    require_root true
    environment_variables NODE_ENV: "production"
    log_path var/"log/tachibana/server.log"
    error_log_path var/"log/tachibana/server.log"
  end

  test do
    assert_match "tachibana", shell_output("#{bin}/tachibana --help 2>&1", 1)
  end
end
