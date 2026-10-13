class Ulak < Formula
  desc "Run Docker workloads on your own server while you edit locally"
  homepage "https://github.com/syy/ulak"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/syy/ulak/releases/download/v0.2.0/ulak-aarch64-apple-darwin.tar.xz"
      sha256 "0184f5b89289fa10fb55236e6dcbaad7909968d3d8835efd59e6fb8a16689855"
    end
    if Hardware::CPU.intel?
      url "https://github.com/syy/ulak/releases/download/v0.2.0/ulak-x86_64-apple-darwin.tar.xz"
      sha256 "aeb7d53a160b14563007e2e2f5d42a954285f51d7a29e4d91cec7d26188e3179"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/syy/ulak/releases/download/v0.2.0/ulak-aarch64-unknown-linux-musl.tar.xz"
      sha256 "2d94e7245a7716aa8ae324c6a39511ef6029b163f56c8e8ceb37c97b668055d6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/syy/ulak/releases/download/v0.2.0/ulak-x86_64-unknown-linux-musl.tar.xz"
      sha256 "f9836994d5e2e21395a3bc1ba5e37ac66372804aae9a8b05bbf53721ce530b08"
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
