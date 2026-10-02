class Tussh < Formula
  desc "SSH connection manager TUI with access control for AI agents"
  homepage "https://github.com/baeroe/tussh"
  url "https://github.com/baeroe/tussh/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "63305870d4916607ba65c007610a80de9f6261e1bd3f0ea20d73af47829b3912"
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
