# Relic Homebrew tap

The official Homebrew tap for [Relic](https://relic.space/), a local-first,
end-to-end encrypted vault for everything you copy.

## Install

```sh
brew tap RelicSync/relic
brew install --cask relic
```

Or in one line:

```sh
brew install --cask RelicSync/relic/relic
```

## Update

```sh
brew update
brew upgrade --cask relic
```

Relic also updates itself in place when a new version is published, so you may
find it has already moved ahead of the tap. That is expected and harmless.

## Uninstall

```sh
brew uninstall --cask relic
```

To remove the vault and every local file Relic created:

```sh
brew uninstall --zap --cask relic
```

The zap deletes your vault. There is no undo, so export first if you want to
keep anything.

## Requirements

- macOS 11 Big Sur or later
- Apple silicon. The build sets `ARCHS = arm64` and bundles the arm64 ONNX
  Runtime that on-device search uses, so there is no Intel build today.

The app is Developer ID signed and notarized, so it opens without a Gatekeeper
prompt and needs no `--no-quarantine`.

## What gets installed

`Relic.app` into `/Applications`, from the signed DMG published at
relic.space. The cask pins an exact versioned URL and its SHA-256, so the bytes
Homebrew installs are the same bytes forever.

## Links

- Source: https://github.com/RelicSync/relic
- Website: https://relic.space/
- Issues: https://github.com/RelicSync/relic/issues
