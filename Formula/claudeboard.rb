class Claudeboard < Formula
  desc "Terminal control panel for Claude Code background sessions"
  homepage "https://github.com/Harris-Ferguson/claudeboard"
  url "https://github.com/Harris-Ferguson/claudeboard/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "ab804ccbabb66d47f31adbd6f9f4569326d4aa2c5ce9e23314966bf38d79efb9"
  head "https://github.com/Harris-Ferguson/claudeboard.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=v#{version}"), "./cmd/claudeboard"
  end

  def caveats
    <<~EOS
      claudeboard drives Claude Code's background sessions, so it needs
      Claude Code 2.1.312 or newer on your PATH (`claude agents --json` must work).
    EOS
  end

  test do
    assert_match "claudeboard v#{version}", shell_output("#{bin}/claudeboard --version")
  end
end
