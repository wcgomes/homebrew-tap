# Formula for personal tap github.com/wcgomes/homebrew-tap.
# After each release: set version, url (if needed), and sha256 of the arm64 tarball.

class Adevcontainer < Formula
  desc "Native Swift CLI for devcontainer.json on Apple container"
  homepage "https://github.com/wcgomes/apple-devcontainers"
  version "0.2.0"
  url "https://github.com/wcgomes/apple-devcontainers/releases/download/v#{version}/adevcontainer-macos-arm64.tar.gz"
  sha256 "17a35c84c821b38025e1c887c9964d3a554e293023ae328a8ef51e0d1612fd4f"
  license "MIT"

  depends_on macos: :tahoe # macOS 26+
  depends_on arch: :arm64

  def install
    bin.install "adevcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/adevcontainer --version")
  end

  def caveats
    <<~EOS
      adevcontainer requires the Apple container CLI on the host (not installed by this formula):
        https://github.com/apple/container

      After install, run:
        adevcontainer doctor
    EOS
  end
end
