class MockeryAT2422 < Formula
  desc "Mock code autogenerator for Golang"
  homepage "https://github.com/vektra/mockery"
  url "https://github.com/vektra/mockery/archive/refs/tags/v2.42.2.tar.gz"
  sha256 "c4ceabcf90a331514caa5288a2a6c3d93e3237be7414d18ea7e14f0e2a961a37"
  license "BSD-3-Clause"
  head "https://github.com/vektra/mockery.git", branch: "v3"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-trimpath", "-o", "mockery", "-ldflags", "-s -w -X github.com/vektra/mockery/v2/pkg/logging.SemVer=v#{version}"
    bin.install "mockery"
    generate_completions_from_executable(bin/"mockery", "completion")
  end

  test do
    output = shell_output("#{bin}/mockery --keeptree 2>&1", 1)
    assert_match "Starting mockery dry-run=false version=v#{version}", output

    output = shell_output("#{bin}/mockery --all --dry-run 2>&1")
    assert_match "INF Starting mockery dry-run=true version=v#{version}", output
  end
end
