# Formula for personal tap github.com/wcgomes/homebrew-tap.
# After each release: set version, url (if needed), and sha256 of the arm64 tarball.

class Adevcontainer < Formula
  desc "Native Swift CLI for devcontainer.json on Apple container"
  homepage "https://github.com/wcgomes/apple-devcontainers"
  version "0.6.0"
  url "https://github.com/wcgomes/apple-devcontainers/releases/download/v#{version}/adevcontainer-macos-arm64.tar.gz"
  sha256 "42d615edf6f1f010703bfe706e506bae9b2476e1792a4c51b3a5cbfc614064bf"
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
