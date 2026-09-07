# homebrew-tap

Homebrew formulae for [Ulak](https://github.com/syy/ulak).

```bash
brew install syy/tap/ulak
brew upgrade ulak
```

The formula installs a prebuilt binary for macOS (Apple silicon, Intel) and
Linux (x86_64, aarch64), and pulls in Homebrew's rsync, which Ulak needs.

`Formula/` is written by Ulak's release workflow on every tagged release.
Do not edit it by hand; a fix belongs in
[`dist-workspace.toml`](https://github.com/syy/ulak/blob/main/dist-workspace.toml)
in the Ulak repository.
