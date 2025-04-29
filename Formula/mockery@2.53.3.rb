class MockeryAT2533 < Formula
  desc "Mock code autogenerator for Golang"
  homepage "https://github.com/vektra/mockery"
  url "https://github.com/vektra/mockery/archive/refs/tags/v2.53.3.tar.gz"
  sha256 "c9495d19de1ca52a61a9ed299d9988a4f4a3cf1ad614954a15ca3920d8b852a2"
  license "BSD-3-Clause"
  head "https://github.com/vektra/mockery.git", branch: "master"

  # There can be a notable gap between when a version is tagged and a
  # corresponding release is created, so we check the "latest" release instead
  # of the Git tags.
  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-s -w -X github.com/vektra/mockery/v2/pkg/logging.SemVer=v#{version}"

    generate_completions_from_executable(bin/"mockery", "completion")
  end

  test do
    output = shell_output("#{bin}/mockery --keeptree 2>&1", 1)
    assert_match "Starting mockery dry-run=false version=v#{version}", output

    output = shell_output("#{bin}/mockery --all --dry-run 2>&1")
    assert_match "INF Starting mockery dry-run=true version=v#{version}", output
  end
end
