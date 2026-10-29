# Update log

## TurboCrypt 0.9.9

The user asked to update the tap for TurboCrypt 0.9.9 and publish it.

Inspected the formula, README, previous update notes, Git status, and recent commits.
This repository publishes a Homebrew tap through the `main` branch on `jedisct1/homebrew-turbocrypt`.
The formula currently installs the universal macOS 0.9.8 executable.
The working tree has no tracked changes.

Confirmed that upstream has published the 0.9.9 universal macOS archive.
Downloaded the archive and verified SHA-256 `35ab6c275b76eb093b0eb7c6b86430924676b945ece917c19ba158425a3c4f64` against the upstream checksum file and GitHub asset metadata.
Updated the formula URL and checksum.
An independent review of upstream changes found no additional packaging changes needed.

Validation passed: Homebrew style, Ruby syntax, and `git diff --check`.
An isolated installation simulation confirmed the executable contains Intel and Apple Silicon architectures and reports version 0.9.9.
Key generation and the formula's encryption/decryption roundtrip passed on Apple Silicon.

During the independent review, the first release lookup targeted the tap instead of the upstream repository, and a raw GitHub API response was incorrectly combined with JSON filtering.
Both queries were corrected; future release queries should explicitly target `jedisct1/turbocrypt`, and raw responses should not use JSON filtering.

Removed the temporary archive, installation, and test files, including the generated test key.
The update is ready to publish by committing the formula and this log, then pushing `main` to `origin`.
Publication will be verified against the remote commit and formula.
