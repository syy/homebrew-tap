class Ulak < Formula
  desc "Run Docker workloads on your own server while you edit locally"
  homepage "https://github.com/syy/ulak"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/syy/ulak/releases/download/v0.3.0/ulak-aarch64-apple-darwin.tar.xz"
      sha256 "4f027abe29b5872a0112c88a8637432c760e1be20352b459c9c212fb16edfc80"
    end
    if Hardware::CPU.intel?
      url "https://github.com/syy/ulak/releases/download/v0.3.0/ulak-x86_64-apple-darwin.tar.xz"
      sha256 "baa2fa3a061900f084836081293a97c5da7bb5ca9c2354428245bb991335b7fa"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/syy/ulak/releases/download/v0.3.0/ulak-aarch64-unknown-linux-musl.tar.xz"
      sha256 "b0bafc2fdf595708fde42fe0d7d305ff04826dd87907242226e1751b16b4c9be"
    end
    if Hardware::CPU.intel?
      url "https://github.com/syy/ulak/releases/download/v0.3.0/ulak-x86_64-unknown-linux-musl.tar.xz"
      sha256 "ca119dc5483ddeac283f2f47820876914519dc37bb0a3ba1bd7cd496e013bb58"
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
