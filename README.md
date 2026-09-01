# MetaPouch Homebrew tap

```sh
brew install metapouch/tap/agentick-runner
```

## Formulae

| | |
|---|---|
| `agentick-runner` | The [Agentick](https://workspace.agentick.xyz) runner — executes agent work on hardware you own. |

Formulae here are **generated** by the release job in the Agentick workspace,
not written by hand. A formula's `sha256` has to match its published artifact
exactly, and a checksum maintained manually is one that is eventually
confidently wrong.

Artifacts come from
[MetaPouch/agentick-runner-releases](https://github.com/MetaPouch/agentick-runner-releases),
which publishes a `SHA256SUMS` you can check independently.

## Not yet signed

Current builds carry an ad-hoc signature rather than a Developer ID. Homebrew
installs are unaffected — macOS quarantine comes from the download method, and
`brew` does not set it — but there is no team identifier for an MDM to
allowlist, and no signature for a security review to verify. That is coming.
