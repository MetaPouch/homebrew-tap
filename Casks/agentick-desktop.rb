# Homebrew cask — the desktop app's Homebrew install path (AGN-294).
#
# A template. `version` and `sha256` below are placeholders; `build-release.sh`
# renders a copy into `release/` with the real values, and that rendered copy
# is what gets committed to the tap. Editing the checksum here by hand is how
# a cask ends up pointing confidently at the wrong bytes.
cask "agentick-desktop" do
  version "0.1.19"
  sha256 "29a49abde27ec3241ea2792071b6d42112a428761883a03c9a0eaf751922f8a4"

  url "https://github.com/MetaPouch/agentick-desktop-releases/releases/download/v#{version}/Agentick-#{version}-arm64.dmg"
  name "Agentick"
  # No trailing period, no repeating the cask's own name — `brew audit
  # --strict` rules, same as the runner's formula.
  desc "The Agentick runner as a desktop app"
  homepage "https://workspace.agentick.xyz"

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
