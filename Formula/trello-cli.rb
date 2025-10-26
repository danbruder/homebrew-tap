class TrelloCli < Formula
  desc "A comprehensive Trello CLI tool for humands and LLMs"
  homepage "https://trello-cli.netlify.app"
  version "1.0.4"
  license "MIT"
  head "https://github.com/danbruder/trello-cli.git", branch: "main"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danbruder/trello-cli/releases/download/v1.0.4/trello-cli-darwin-arm64"
      sha256 "f291f26c14cb5a4fee9d6b2c7b70538d6230aebd6764e23b80bb6e23a035f97b"
    else
      url "https://github.com/danbruder/trello-cli/releases/download/v1.0.4/trello-cli-darwin-amd64"
      sha256 "887ee3d74ba293b0dc9975f0bd0a097baf6cb97752fd9214091dcd64ad9b5cb3"
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
