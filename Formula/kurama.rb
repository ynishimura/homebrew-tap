class Kurama < Formula
  desc "Credential switcher and API client for the terminal: AWS roles with MFA from 1Password, OAuth and API-key sources, an OpenAPI explorer, and local data and database access"
  homepage "https://github.com/ynishimura/kurama"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ynishimura/kurama/releases/download/v0.1.0/kurama-aarch64-apple-darwin.tar.xz"
      sha256 "0f82cb1c6064bcaa7b3e97b8115f3ff032a96e28e731cde2e2a0b0af79526909"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynishimura/kurama/releases/download/v0.1.0/kurama-x86_64-apple-darwin.tar.xz"
      sha256 "84c543fafb22c14c33248d18c3e7cb60c822961e31622361c86187b3e82d34fe"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ynishimura/kurama/releases/download/v0.1.0/kurama-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "938bba8004d789171002952c9508ec417db4eed7a8c6840dc2a1c0d552bf4b96"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynishimura/kurama/releases/download/v0.1.0/kurama-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c8db849ff538ac160a61eea9e274c6a48a5c2912740f3f95f819296982f0f526"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "kurama"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "kurama"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "kurama"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "kurama"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
