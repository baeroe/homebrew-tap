class Skilltri < Formula
  desc "MCP gateway and agent skill manager with per-folder rules for AI agent harnesses"
  homepage "https://github.com/baeroe/skilltri"
  url "https://github.com/baeroe/skilltri/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "9e1533f1a77e8e8226ad362782d20bc646dd142435762a6ab21eb0d14577cd85"
  license "MIT"
  head "https://github.com/baeroe/skilltri.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-X main.version=#{version}")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skilltri version")
  end
end
