# baeroe/homebrew-tap

Homebrew formulae for tools by [@baeroe](https://github.com/baeroe).

```sh
brew install baeroe/tap/<formula>
```

| Formula | Description |
|---|---|
| [`tussh`](https://github.com/baeroe/tussh) | SSH connection manager TUI with access control for AI agents |
| [`lazy1mcp`](https://github.com/baeroe/lazy1mcp) | Terminal UI to see and manage the MCP servers of a 1MCP instance |

Formulae build from the tagged source release, so there are no unsigned binaries for Gatekeeper to block.

## How updates work

`.github/workflows/tests.yml` runs every hour and on demand. It checks each formula's repository (`baeroe/<formula>`) for a newer GitHub release (`scripts/bump.sh`), updates `url` and `sha256`, and builds, tests and audits the formula on macOS before committing the bump. Pushes and pull requests run the same build and test.

To bump by hand:

```sh
scripts/bump.sh tussh baeroe/tussh
```

## License

MIT, see [LICENSE](LICENSE).
