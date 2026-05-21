# Homebrew Cask for MATTE — desktop bulk processor.
#
# This file is auto-updated by the release workflow in the
# spinsoft-transcription/matte project repo (private). Each `v*`
# tag push rewrites `version` + `sha256` here to match the latest
# universal macOS .app tarball.
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
  version "0.1.1"
  sha256 "5433f3382317961a4513293c3ccfbd80764cf1abd25fb60ee507b717ecc47f80"

  url "https://github.com/spinsoft-transcription/matte-gui-release/releases/download/v0.1.1/matte-gui-v0.1.1-macos-universal.tar.gz"
  name "MATTE"
  desc "Bulk chromakey + LUT + auto-frame compositor (iced desktop GUI)"
  homepage "https://github.com/spinsoft-transcription/matte"

  # `depends_on formula: ...` only triggers when the dependency
  # isn't already installed; existing ffmpeg installs are reused.
  depends_on formula: "ffmpeg"
  depends_on macos: ">= :catalina" # matches Info.plist LSMinimumSystemVersion 10.15

  app "matte-gui.app"

  # `zap` removes leftover settings on `brew uninstall --zap`.
  # Users who just `brew uninstall` keep their settings, which is
  # the right default — config.json + LUT paths take effort to
  # rebuild.
  zap trash: [
    "~/Library/Application Support/com.spinsoft.MATTE",
  ]

  caveats <<~EOS
    MATTE is unsigned (current v0.1.x releases ship without an
    Apple Developer ID). If macOS refuses to launch the app the
    first time with "matte-gui cannot be opened because the
    developer cannot be verified", clear the quarantine bit once:

        xattr -dr com.apple.quarantine "#{appdir}/matte-gui.app"

    Or use System Settings → Privacy & Security → "Open Anyway".

    Settings persist at:
        ~/Library/Application Support/com.spinsoft.MATTE/
  EOS
end
