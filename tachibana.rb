class Tachibana < Formula
  desc "Multi-platform iOS device manipulation suite"
  homepage "https://github.com/Paranoid-AF/tachibana"
  version "0.0.1-dev.1"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Paranoid-AF/tachibana/releases/download/v0.0.1-dev.1/tachibana-darwin-arm64.tar.gz"
      sha256 "78eae0d8192b9d8e5e513f2c1eb141f7d4e476475c0b2b8f085a0d250535c2fa"
    else
      url "https://github.com/Paranoid-AF/tachibana/releases/download/v0.0.1-dev.1/tachibana-darwin-x64.tar.gz"
      sha256 "7d12892e4b37f4a39a2890fb6112cb12b0efe81266ee2e4e5aebdadbcf098de3"
    end
  end

  def install
    bin.install "tachibana"
    prefix.install "bin"
    prefix.install "drizzle"
    prefix.install "web"
    if File.directory?("assets")
      prefix.install "assets"
    end
  end

  service do
    run [opt_bin/"tachibana"]
    working_dir opt_prefix
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
