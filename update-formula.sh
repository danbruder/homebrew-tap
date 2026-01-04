#!/bin/bash

# Script to update trello-cli Homebrew formula with new version and SHA256 hashes
# Usage: ./update-formula.sh <version>
# Example: ./update-formula.sh 1.2.0

set -e

if [ -z "$1" ]; then
  echo "Error: Version number required"
  echo "Usage: $0 <version>"
  echo "Example: $0 1.2.0"
  exit 1
fi

VERSION=$1
FORMULA_FILE="Formula/trello-cli.rb"
TEMP_DIR=$(mktemp -d)

echo "Updating trello-cli formula to version $VERSION"

# GitHub release base URL
BASE_URL="https://github.com/danbruder/trello-cli/releases/download/v${VERSION}"

# Download binaries and calculate SHA256 hashes
echo ""
echo "Downloading binaries and calculating SHA256 hashes..."

echo "  darwin-arm64..."
curl -L -s -o "$TEMP_DIR/darwin-arm64" "$BASE_URL/trello-cli-darwin-arm64"
DARWIN_ARM64_SHA=$(shasum -a 256 "$TEMP_DIR/darwin-arm64" | awk '{print $1}')
echo "    $DARWIN_ARM64_SHA"

echo "  darwin-amd64..."
curl -L -s -o "$TEMP_DIR/darwin-amd64" "$BASE_URL/trello-cli-darwin-amd64"
DARWIN_AMD64_SHA=$(shasum -a 256 "$TEMP_DIR/darwin-amd64" | awk '{print $1}')
echo "    $DARWIN_AMD64_SHA"

echo "  linux-arm64..."
curl -L -s -o "$TEMP_DIR/linux-arm64" "$BASE_URL/trello-cli-linux-arm64"
LINUX_ARM64_SHA=$(shasum -a 256 "$TEMP_DIR/linux-arm64" | awk '{print $1}')
echo "    $LINUX_ARM64_SHA"

echo "  linux-amd64..."
curl -L -s -o "$TEMP_DIR/linux-amd64" "$BASE_URL/trello-cli-linux-amd64"
LINUX_AMD64_SHA=$(shasum -a 256 "$TEMP_DIR/linux-amd64" | awk '{print $1}')
echo "    $LINUX_AMD64_SHA"

# Clean up temp files
rm -rf "$TEMP_DIR"

echo ""
echo "Updating formula file..."

# Use Ruby to update the formula file
ruby -e "
content = File.read('$FORMULA_FILE')

# Update version
content.gsub!(/version \"[^\"]*\"/, 'version \"$VERSION\"')

# Update URLs and hashes
content.gsub!(
  %r{https://github\.com/danbruder/trello-cli/releases/download/v[^/]+/trello-cli-darwin-arm64},
  '$BASE_URL/trello-cli-darwin-arm64'
)
content.gsub!(
  %r{https://github\.com/danbruder/trello-cli/releases/download/v[^/]+/trello-cli-darwin-amd64},
  '$BASE_URL/trello-cli-darwin-amd64'
)
content.gsub!(
  %r{https://github\.com/danbruder/trello-cli/releases/download/v[^/]+/trello-cli-linux-arm64},
  '$BASE_URL/trello-cli-linux-arm64'
)
content.gsub!(
  %r{https://github\.com/danbruder/trello-cli/releases/download/v[^/]+/trello-cli-linux-amd64},
  '$BASE_URL/trello-cli-linux-amd64'
)

# Update SHA256 hashes in order: darwin-arm64, darwin-amd64, linux-arm64, linux-amd64
lines = content.split(\"\n\")
sha_index = 0
sha_values = ['$DARWIN_ARM64_SHA', '$DARWIN_AMD64_SHA', '$LINUX_ARM64_SHA', '$LINUX_AMD64_SHA']

lines.each_with_index do |line, i|
  if line =~ /sha256/ && sha_index < sha_values.length
    indent = line[/^\s*/]
    lines[i] = \"#{indent}sha256 \\\"#{sha_values[sha_index]}\\\"\"
    sha_index += 1
  end
end

File.write('$FORMULA_FILE', lines.join(\"\n\") + \"\n\")
"

echo ""
echo "Formula updated successfully!"
echo ""
echo "Summary:"
echo "  Version: $VERSION"
echo "  macOS ARM64: $DARWIN_ARM64_SHA"
echo "  macOS AMD64: $DARWIN_AMD64_SHA"
echo "  Linux ARM64: $LINUX_ARM64_SHA"
echo "  Linux AMD64: $LINUX_AMD64_SHA"
echo ""
echo "Next steps:"
echo "  1. Review the changes: git diff $FORMULA_FILE"
echo "  2. Test the formula: brew install --build-from-source $FORMULA_FILE"
echo "  3. Commit the changes: git add $FORMULA_FILE && git commit -m 'Update to v$VERSION'"
