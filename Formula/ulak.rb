class Ulak < Formula
  desc "Run Docker workloads on your own server while you edit locally"
  homepage "https://github.com/syy/ulak"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/syy/ulak/releases/download/v0.1.0/ulak-aarch64-apple-darwin.tar.xz"
      sha256 "c974dfdfb680ee77128b2e1e2739758ddf42b542d5ebec8d5eacd44769a7e8e7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/syy/ulak/releases/download/v0.1.0/ulak-x86_64-apple-darwin.tar.xz"
      sha256 "de1b0d8b2f0927e241d91606c0433d328a1215f418d9e4b7b0148d42d9ea0a3d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/syy/ulak/releases/download/v0.1.0/ulak-aarch64-unknown-linux-musl.tar.xz"
      sha256 "156f3363c40ca5bad22545261fe43c01f29ca287d144a17f6396e567c7198e15"
    end
    if Hardware::CPU.intel?
      url "https://github.com/syy/ulak/releases/download/v0.1.0/ulak-x86_64-unknown-linux-musl.tar.xz"
      sha256 "612ac3f54bd8863b6e1d8611e4e6eb08925761ee051987dd56453e556abac017"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]
  depends_on "rsync"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
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
      bin.install "ulak"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ulak"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ulak"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ulak"
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
