# Homebrew cask — the desktop app's Homebrew install path (AGN-294).
#
# A template. `version` and `sha256` below are placeholders; `build-release.sh`
# renders a copy into `release/` with the real values, and that rendered copy
# is what gets committed to the tap. Editing the checksum here by hand is how
# a cask ends up pointing confidently at the wrong bytes.
cask "agentick-desktop" do
  version "0.1.31"
  sha256 "0d1b1b48f9393c6754c0fae6de5f2f4179f876927cadc3f9fa5c5e3ae1cded48"

  url "https://github.com/MetaPouch/agentick-desktop-releases/releases/download/v#{version}/Agentick-#{version}-arm64.dmg"
  name "Agentick"
  # No trailing period, no repeating the cask's own name — `brew audit
  # --strict` rules, same as the runner's formula.
  desc "The Agentick runner as a desktop app"
  homepage "https://console.agentick.xyz"

  # The app updates itself from the same releases (AGN-346), so the version
  # brew recorded at install goes stale by design. Without this, `brew
  # upgrade` would reinstall over a newer self-updated app, or downgrade it
  # while the tap lags a release. `brew upgrade --greedy` still upgrades it.
  auto_updates true

  # arch before macos, also an audit rule.
  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Agentick.app"

  # `app.setName('Agentick')` (apps/desktop/src/main/index.ts) is what makes
  # Electron's userData path this rather than "Electron".
  zap trash: [
    "~/Library/Application Support/Agentick",
    "~/Library/Preferences/com.agentick.desktop.plist",
    "~/Library/Saved Application State/com.agentick.desktop.savedState",
  ]
end
