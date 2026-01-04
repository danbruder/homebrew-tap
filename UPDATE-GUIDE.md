# Updating the Homebrew Formula

This repository includes an automated script to update the trello-cli Homebrew formula with new versions.

## Quick Update

To update to a new version:

```bash
./update-formula.sh <version>
```

Example:
```bash
./update-formula.sh 1.3.0
```

## What the script does

1. Downloads all platform binaries from the GitHub release:
   - macOS ARM64 (Apple Silicon)
   - macOS AMD64 (Intel)
   - Linux ARM64
   - Linux AMD64

2. Calculates SHA256 hashes for each binary

3. Updates `Formula/trello-cli.rb` with:
   - New version number
   - Updated download URLs
   - Correct SHA256 hashes for each platform

## After running the script

1. Review the changes:
   ```bash
   git diff Formula/trello-cli.rb
   ```

2. (Optional) Test the formula locally:
   ```bash
   brew install --build-from-source Formula/trello-cli.rb
   ```

3. Commit and push the changes:
   ```bash
   git add Formula/trello-cli.rb
   git commit -m "Update to v1.3.0"
   git push
   ```

## Prerequisites

- `curl` for downloading binaries
- `shasum` for calculating SHA256 hashes
- `ruby` for updating the formula file
- Internet connection to download binaries from GitHub releases

## Notes

- The script expects binaries to be available at:
  `https://github.com/danbruder/trello-cli/releases/download/v<version>/trello-cli-<platform>`

- Make sure the GitHub release exists before running the script
