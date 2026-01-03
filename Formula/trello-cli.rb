class TrelloCli < Formula
  desc "A comprehensive Trello CLI tool for humands and LLMs"
  homepage "https://trello-cli.netlify.app"
  version "1.1.0"
  license "MIT"
  head "https://github.com/danbruder/trello-cli.git", branch: "main"

  # Support macOS and Linux with prebuilt binaries

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danbruder/trello-cli/releases/download/v1.1.0/trello-cli-darwin-arm64"
      sha256 "ee91b16ce9b05c7e031a9747fe5a84966a030c670ad68f8f3073fdfe74c1207b"
    else
      url "https://github.com/danbruder/trello-cli/releases/download/v1.1.0/trello-cli-darwin-amd64"
      sha256 "7a3f6ea7f07d794ec315aeaadf24a3209d54c962c20956cbf4e2c17f3842dcc2"
    end

    def install
      bin.install Dir["trello-cli*"].first => "trello-cli"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/danbruder/trello-cli/releases/download/v1.1.0/trello-cli-linux-arm64"
      sha256 "6c1b9a4524da06adbfaaef94221ad1a7f2d1257c61a43d197a46093c08c02a05"
    else
      url "https://github.com/danbruder/trello-cli/releases/download/v1.1.0/trello-cli-linux-amd64"
      sha256 "67b7c463f70df04e3ed3ed1fe9735bea30f05f58b2faf6815126ed37edc27d1a"
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
