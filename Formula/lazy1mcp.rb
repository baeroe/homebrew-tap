class Lazy1mcp < Formula
  desc "Terminal UI to see and manage the MCP servers of a 1MCP instance"
  homepage "https://github.com/baeroe/lazy1mcp"
  url "https://github.com/baeroe/lazy1mcp/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "8b1603786aa998e657fa7fbf4dc4cfd88bec200a7e5f1cb4997576571def2fc2"
  license "MIT"
  head "https://github.com/baeroe/lazy1mcp.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-X main.version=#{version}")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lazy1mcp version")
  end
end
