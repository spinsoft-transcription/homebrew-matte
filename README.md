# homebrew-matte

Homebrew tap for [spinsoft-transcription/matte][matte] — the MATTE
chromakey + LUT compositor desktop app.

## Install

```sh
brew install spinsoft-transcription/matte/matte-gui
```

Brew auto-taps this repo from the `<org>/<tap-suffix>/<formula>`
form, so no separate `brew tap` step is needed. `depends_on
"ffmpeg"` in the formula pulls ffmpeg in transparently.

## Upgrade

```sh
brew update && brew upgrade matte-gui
```

## Uninstall

```sh
brew uninstall matte-gui
```

## What lives here

- [`Formula/matte-gui.rb`](Formula/matte-gui.rb) — the formula.
  Auto-bumped by the release workflow in the project repo on
  every `v*` tag push (version + sha256 only).

Manual edits land here when something structural changes (license,
deps, install layout). For version bumps, prefer pushing a tag in
the project repo and letting the bump action handle it.

[matte]: https://github.com/spinsoft-transcription/matte
