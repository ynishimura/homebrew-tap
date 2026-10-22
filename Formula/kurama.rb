class Kurama < Formula
  desc "Credentials and APIs for coding agents: AWS roles with MFA, OAuth and API keys, OpenAPI, data, databases"
  homepage "https://github.com/ynishimura/kurama"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ynishimura/kurama/releases/download/v0.2.0/kurama-aarch64-apple-darwin.tar.xz"
      sha256 "c0211fefa4fb779b690d204b10b914c5f183822692a590417fa53801bc2e4c7a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynishimura/kurama/releases/download/v0.2.0/kurama-x86_64-apple-darwin.tar.xz"
      sha256 "44b0d5fb93c161745b479567e83ad46042940a1f14f46aa99ab0d993a6bcfde0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ynishimura/kurama/releases/download/v0.2.0/kurama-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c24fc2075eb901597b93247db50cb193137de222913bf6af39495d24858a1409"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynishimura/kurama/releases/download/v0.2.0/kurama-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bb6fcf94128ed557fdca459d614a5561a16281046ffa959212b8e5ae99bd0971"
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
