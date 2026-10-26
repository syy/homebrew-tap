class Ulak < Formula
  desc "Run Docker workloads on your own server while you edit locally"
  homepage "https://github.com/syy/ulak"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/syy/ulak/releases/download/v0.3.1/ulak-aarch64-apple-darwin.tar.xz"
      sha256 "0a85a2741e365d7401ba7e61b8f743304e509cf6e4d3087fec4c047351ae664e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/syy/ulak/releases/download/v0.3.1/ulak-x86_64-apple-darwin.tar.xz"
      sha256 "a63d3ac382481ecf90e6c2b82c41960293091e696d434ab5f1637b56990b273b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/syy/ulak/releases/download/v0.3.1/ulak-aarch64-unknown-linux-musl.tar.xz"
      sha256 "b01993cd60ca4f2924f77d6313e3735df05a3f19c1265df2cfb3f62b5fc4e3b2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/syy/ulak/releases/download/v0.3.1/ulak-x86_64-unknown-linux-musl.tar.xz"
      sha256 "ebe5c97562faa846cb9d1505cfb3946681cdaf929ec7ba97c3643173070de171"
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
