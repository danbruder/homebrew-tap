class TrelloCli < Formula
  desc "A comprehensive Trello CLI tool for humands and LLMs"
  homepage "https://trello-cli.netlify.app"
  version "1.2.0"
  license "MIT"
  head "https://github.com/danbruder/trello-cli.git", branch: "main"

  # Support macOS and Linux with prebuilt binaries

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danbruder/trello-cli/releases/download/v1.2.0/trello-cli-darwin-arm64"
      sha256 "143f4c7577e0b1ce52311a51aaf391963ed19321e47c6b94b1881e93ca40013e"
    else
      url "https://github.com/danbruder/trello-cli/releases/download/v1.2.0/trello-cli-darwin-amd64"
      sha256 "1c6d6e5d279400412509df796b9eeb1cbc8d3abda50540da4e07c47f3a310534"
    end

    def install
      bin.install Dir["trello-cli*"].first => "trello-cli"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/danbruder/trello-cli/releases/download/v1.2.0/trello-cli-linux-arm64"
      sha256 "f0748204f5d877c3ef3db382586c3a497bf1f3cee6d4ebb552fda4435fd04a87"
    else
      url "https://github.com/danbruder/trello-cli/releases/download/v1.2.0/trello-cli-linux-amd64"
      sha256 "c0d378a50bde3f6275fe40bf76b17ccc40b6f21c814f2d9d7c90c567fa99dfb4"
    end

    def install
      bin.install Dir["trello-cli*"].first => "trello-cli"
    end
  end

  test do
    # Test that the binary works
    system "#{bin}/trello-cli", "--help"
  end
end
