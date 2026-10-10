class Kurama < Formula
  desc "Credentials and APIs for coding agents: AWS roles with MFA, OAuth and API keys, OpenAPI, data, databases"
  homepage "https://github.com/ynishimura/kurama"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ynishimura/kurama/releases/download/v0.1.2/kurama-aarch64-apple-darwin.tar.xz"
      sha256 "0980aad39e189658443553485c17f5ed88e1ac2f5cca77dc96ee43ddaf42e06d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynishimura/kurama/releases/download/v0.1.2/kurama-x86_64-apple-darwin.tar.xz"
      sha256 "3bef8a8b4f65a74a79c9d5b7e0cf127bf90ca2aaddef87da37a502ad36ebc1dd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ynishimura/kurama/releases/download/v0.1.2/kurama-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "66a445707648aa3b69b547e1fec6a3481b4e933ac2cc88277557a5328f0c0204"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynishimura/kurama/releases/download/v0.1.2/kurama-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "73b5f5fdb68f78eff4cd706708447d0970a66a53d2f508f2624b2cfdf3461a5c"
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
