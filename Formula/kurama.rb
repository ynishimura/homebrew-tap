class Kurama < Formula
  desc "Credentials and APIs for coding agents: AWS roles with MFA, OAuth and API keys, OpenAPI, data, databases"
  homepage "https://github.com/ynishimura/kurama"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ynishimura/kurama/releases/download/v0.1.1/kurama-aarch64-apple-darwin.tar.xz"
      sha256 "92087207b3507e07b44286bc6708496f8fc0db39d9f26fe68077be78464a81df"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynishimura/kurama/releases/download/v0.1.1/kurama-x86_64-apple-darwin.tar.xz"
      sha256 "e09141dd040e2aabb0176541d32fcfa34bcec7e6c295b61d82ec9d888e2a40f6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ynishimura/kurama/releases/download/v0.1.1/kurama-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bbc1b1470ccd66ff046ca4b4ed3bf1a500fb0aee0aa7e751be9f0537f7fb865c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynishimura/kurama/releases/download/v0.1.1/kurama-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "989e1ac530964d31f6b44424649f6c9bab711681c05925d554b8b696df36e79c"
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
