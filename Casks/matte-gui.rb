# Homebrew Cask for MATTE — desktop bulk processor.
#
# This file is auto-updated by the release workflow in the
# spinsoft-transcription/matte project repo (private). Each `v*`
# tag push rewrites `version` + `sha256` here to match the latest
# Apple-Silicon-only macOS .app tarball.
#
# Install:
#     brew install --cask spinsoft-transcription/matte/matte-gui
#
# Casks (not Formulas) are the right shape for GUI apps that
# ship as `.app` bundles — they drop the bundle into
# /Applications and Finder/Launchpad/Spotlight all recognise it.
# The companion Formula at Formula/matte-gui.rb stays around as a
# CLI fallback (raw universal binary, no .app), but the Cask
# install is what users actually want.

cask "matte-gui" do
  version "0.1.5"
  sha256 "376ec5456c0fafb8cf82b7a37e197ab994a72082b9eebc139bdfe3e2850ba848"

  url "https://github.com/spinsoft-transcription/matte-gui-release/releases/download/v0.1.5/matte-gui-v0.1.5-macos-arm64.tar.gz"
  name "MATTE"
  desc "Bulk chromakey + LUT + auto-frame compositor (iced desktop GUI)"
  homepage "https://github.com/spinsoft-transcription/matte"

  # `depends_on formula: ...` only triggers when the dependency
  # isn't already installed; existing ffmpeg installs are reused.
  depends_on formula: "ffmpeg"
  # Arm64-only since v0.1.4 — the macOS tarball ships a single
  # aarch64 Mach-O, not a universal binary. Intel Macs get a clean
  # "wrong architecture" error from brew at this gate instead of
  # an opaque runtime crash when the binary tries to launch under
  # Rosetta and finds no x86_64 slice.
  depends_on arch: :arm64
  # Bumped from Catalina with the arm64 switch: Big Sur (11.0) is
  # the first macOS that runs on Apple Silicon. Matches the
  # Info.plist LSMinimumSystemVersion baked into the .app.
  depends_on macos: ">= :big_sur"

  app "matte-gui.app"

  # MATTE ships unsigned (no Apple Developer ID). brew downloads
  # set the `com.apple.quarantine` xattr by default, which makes
  # Gatekeeper refuse first-launch with "developer cannot be
  # verified". Strip the attribute right after install so the user
  # never sees the warning. Safe to run repeatedly — `xattr -d`
  # against a missing attribute exits non-zero, hence
  # `must_succeed: false` (covers re-install onto an already-clean
  # .app and pre-Sierra macOS that doesn't quarantine at all).
  postflight do
    system_command "/usr/bin/xattr",
                   args:         ["-dr", "com.apple.quarantine", "#{appdir}/matte-gui.app"],
                   sudo:         false,
                   must_succeed: false
  end

  # `zap` removes leftover settings on `brew uninstall --zap`.
  # Users who just `brew uninstall` keep their settings, which is
  # the right default — config.json + LUT paths take effort to
  # rebuild.
  zap trash: [
    "~/Library/Application Support/com.spinsoft.MATTE",
  ]

  caveats <<~EOS
    Settings persist at:
        ~/Library/Application Support/com.spinsoft.MATTE/

    MATTE is unsigned (no Apple Developer ID yet). The cask
    auto-strips the macOS quarantine bit on install, so first
    launch should "just work". If Gatekeeper still flags it on
    your macOS version, use System Settings → Privacy & Security
    → "Open Anyway".
  EOS
end
