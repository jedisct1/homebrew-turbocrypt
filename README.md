# TurboCrypt for Homebrew

Install [TurboCrypt](https://github.com/jedisct1/turbocrypt) on macOS 13 or later. Trust the tap first, then install:

```sh
brew trust jedisct1/turbocrypt
brew install jedisct1/turbocrypt/turbocrypt
```

The universal executable runs on Apple Silicon and Intel Macs and is signed with Frank Denis's Apple Developer ID. Shell completions for Bash, Zsh, and Fish are included.

To update:

```sh
brew update
brew upgrade turbocrypt
```

To use encrypted mounts, also install fuse-t:

```sh
brew install --cask fuse-t
```

Encryption, decryption, and Git integration don't require fuse-t.
