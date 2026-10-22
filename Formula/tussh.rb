class Tussh < Formula
  desc "SSH connection manager TUI with access control for AI agents"
  homepage "https://github.com/baeroe/tussh"
  url "https://github.com/baeroe/tussh/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "023a38f73c64b6c60100a1506e212edf721a095993f4deaa6dd032dbb7d385da"
  license "MIT"
  head "https://github.com/baeroe/tussh.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-X main.version=#{version}")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tussh version")
  end
end
