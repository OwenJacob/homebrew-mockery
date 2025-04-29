class MockeryAT2320 < Formula
  desc "Mock code autogenerator for Golang"
  homepage "https://github.com/vektra/mockery"
  url "https://github.com/vektra/mockery/archive/refs/tags/v2.32.0.tar.gz"
  sha256 "1252e562ccf874195044ef061be5a3e9897625acb57d75ad82c7ce7fd59d0ba6"
  license "BSD-3-Clause"
  head "https://github.com/vektra/mockery.git", branch: "v3"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-trimpath", "-o", "bin/mockery", "-ldflags", "-s -w -X github.com/vektra/mockery/v2/pkg/logging.SemVer=v#{version}"

    generate_completions_from_executable("bin/mockery", "completion")
  end

  test do
    output = shell_output("#{bin}/mockery --keeptree 2>&1", 1)
    assert_match "Starting mockery dry-run=false version=v#{version}", output

    output = shell_output("#{bin}/mockery --all --dry-run 2>&1")
    assert_match "INF Starting mockery dry-run=true version=v#{version}", output
  end
end
