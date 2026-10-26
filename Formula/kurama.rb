class Kurama < Formula
  desc "Credentials and APIs for coding agents: AWS roles with MFA, OAuth and API keys, OpenAPI, data, databases"
  homepage "https://github.com/ynishimura/kurama"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ynishimura/kurama/releases/download/v0.2.1/kurama-aarch64-apple-darwin.tar.xz"
      sha256 "d7c8a1e827fc967409db08948f79fe8831c79c1e0992220daaa55fa2cadf3133"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynishimura/kurama/releases/download/v0.2.1/kurama-x86_64-apple-darwin.tar.xz"
      sha256 "5c325300e6cc9180fcd515d6f164d3c5e8fe2eeff0e7faf6cf339710d38d3654"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ynishimura/kurama/releases/download/v0.2.1/kurama-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f5cab006fe74843d468cd47f37081d06cf97b98ac8b8169615cdb1a084c409ac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynishimura/kurama/releases/download/v0.2.1/kurama-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "edab9b73575f480573fe36dc86077ef4c760ce852548ed04c62a28d65c3313e5"
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
