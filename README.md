# homebrew-matte

Homebrew tap for [spinsoft-transcription/matte][matte] — the MATTE
chromakey + LUT compositor desktop app. Distribution lives in
[`spinsoft-transcription/matte-gui-release`][release-repo] (public
artifacts, no source).

## Install

```sh
brew install spinsoft-transcription/matte/matte-gui
```

Brew auto-taps this repo from the `<org>/<tap-suffix>/<formula>`
form, so no separate `brew tap` step is needed. The Cask:

- Drops `matte-gui.app` into `/Applications` (icon shows up in
  Finder / Launchpad / Spotlight).
- Pulls in `ffmpeg` via the `depends_on formula:` declaration.
- Targets macOS ≥ Catalina (10.15).

## Upgrade

```sh
brew update && brew upgrade --cask matte-gui
```

## Uninstall

```sh
brew uninstall --cask matte-gui          # keeps your settings
brew uninstall --cask --zap matte-gui    # also wipes ~/Library/Application Support/com.spinsoft.MATTE
```

## What lives here

- [`Casks/matte-gui.rb`](Casks/matte-gui.rb) — the Cask, the
  install-method for the GUI app. Auto-bumped (version + sha256)
  by the release workflow in the project repo on every `v*` tag
  push.

Manual edits land here when something structural changes (license,
deps, install layout). For version bumps, prefer pushing a tag in
the project repo and letting the bump action handle it.

[matte]: https://github.com/spinsoft-transcription/matte
[release-repo]: https://github.com/spinsoft-transcription/matte-gui-release
