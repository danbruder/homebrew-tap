class TrelloCli < Formula
  desc "A comprehensive Trello CLI tool for humands and LLMs"
  homepage "https://trello-cli.netlify.app"
  version "1.3.0"
  license "MIT"
  head "https://github.com/danbruder/trello-cli.git", branch: "main"

  # Support macOS and Linux with prebuilt binaries

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danbruder/trello-cli/releases/download/v1.3.0/trello-cli-darwin-arm64"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    else
      url "https://github.com/danbruder/trello-cli/releases/download/v1.3.0/trello-cli-darwin-amd64"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    end

    def install
      bin.install Dir["trello-cli*"].first => "trello-cli"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/danbruder/trello-cli/releases/download/v1.3.0/trello-cli-linux-arm64"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    else
      url "https://github.com/danbruder/trello-cli/releases/download/v1.3.0/trello-cli-linux-amd64"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
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
