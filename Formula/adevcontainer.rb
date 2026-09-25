# Formula for personal tap github.com/wcgomes/homebrew-tap.
# After each release: set version, url (if needed), and sha256 of the arm64 tarball.

class Adevcontainer < Formula
  desc "Native Swift CLI for devcontainer.json on Apple container"
  homepage "https://github.com/wcgomes/apple-devcontainers"
  version "0.9.2"
  url "https://github.com/wcgomes/apple-devcontainers/releases/download/v#{version}/adevcontainer-macos-arm64.tar.gz"
  sha256 "36abb0bbd95eac3c960faab638142e182d353ef989b84143dd4a76da0d8c28e3"
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

      After install, link the `container dev` plugin once (and again only after
      upgrading Apple container):
        sudo adevcontainer plugin --install

      brew upgrade adevcontainer does not require plugin --install again when
      the plugin symlink already targets $(brew --prefix)/opt/adevcontainer/bin/adevcontainer.

      After install, run:
        adevcontainer doctor
    EOS
  end
end
