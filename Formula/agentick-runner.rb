# Homebrew formula — the developer install path (AGN-77, AGN-152, doc 9 §8.1).
#
# **A template.** `url`, `sha256` and `version` below are placeholders;
# `build-release.sh` renders a copy into `dist/` with the real values, and that
# rendered copy is what gets committed to the tap. Editing the checksum here by
# hand is how a formula ends up pointing confidently at the wrong bytes.
#
# Two install paths on purpose. The .pkg is for a customer's IT, who want
# something they can push through MDM and audit. This is for a developer trying
# the product on their own Mac, who will not wait for a change-management
# ticket to do it. `install.sh` is the third, for people who want neither.
class AgentickRunner < Formula
  # Not starting with the formula's own name, and no trailing period: both are
  # `brew audit --strict` rules, and a formula that fails audit is one no
  # reviewer will take seriously.
  desc "Executes agent work on hardware you own"
  homepage "https://workspace.agentick.xyz"
  url "https://github.com/MetaPouch/agentick-runner-releases/releases/download/v0.2.0/agentick-runner-macos-arm64.tar.gz"
  sha256 "03fdcea2f4fe7233dea4fa76441ce38808fbb0f2fb46d30cd4184ca312aa24ae"
  license :cannot_represent

  # No `version` stanza: brew scans it from the URL, and declaring it as well is
  # redundant — audit flags it, and the two could disagree.
  #
  # arch before macos, also an audit rule.
  depends_on arch: :arm64
  depends_on :macos
  # Claude Code runs inside a tmux session, which owns its terminal (AGN-288).
  depends_on "tmux"

  def install
    bin.install "agentick-runner"
  end

  def caveats
    <<~EOS
      The runner installs as a LaunchAgent, not a LaunchDaemon, because the
      Keychain holding your inference key is unlocked by your login session.

      That means it only runs while someone is logged in. After a reboot on a
      FileVault machine it stays down until a human unlocks the Mac.

      Next:
        agentick-runner enroll --url https://workspace.agentick.xyz --token agrt_...
        pbpaste | agentick-runner set-key
        agentick-runner install-agent --url https://workspace.agentick.xyz

      Homebrew installs unprivileged, so per-step user isolation is not set up
      on this path. Run `agentick-runner provision-users` and follow its output
      as an administrator if you want it.
    EOS
  end

  test do
    assert_match "usage", shell_output("#{bin}/agentick-runner 2>&1", 2)
  end
end
