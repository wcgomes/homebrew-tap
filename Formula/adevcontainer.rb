# Formula for personal tap github.com/wcgomes/homebrew-tap.
# After each release: set version, url (if needed), and sha256 of the arm64 tarball.

class Adevcontainer < Formula
  desc "Native Swift CLI for devcontainer.json on Apple container"
  homepage "https://github.com/wcgomes/apple-devcontainers"
  version "0.8.1"
  url "https://github.com/wcgomes/apple-devcontainers/releases/download/v#{version}/adevcontainer-macos-arm64.tar.gz"
  sha256 "718105a5b4f3dd01a9dd93aa72f6d3a1308a294174d14a63e965ed4d3e597009"
  license "MIT"

  depends_on macos: :tahoe # macOS 26+
  depends_on arch: :arm64

  def install
    bin.install "adevcontainer"
  end

  def post_install
    container_path = "/usr/local/bin/container"
    container_path = which("container").to_s unless File.executable?(container_path)
    odie "Apple container CLI not found at /usr/local/bin/container or on PATH" if container_path.to_s.empty?
    install_root = File.dirname(File.dirname(container_path))
    plugin_root = File.join(install_root, "libexec", "container-plugins", "dev")
    plugin_bin = File.join(plugin_root, "bin")
    mkdir_p plugin_bin
    cp bin/"adevcontainer", File.join(plugin_bin, "dev")
    chmod 0755, File.join(plugin_bin, "dev")
    File.write(File.join(plugin_root, "config.toml"), <<~TOML)
      abstract = "Native Swift CLI for devcontainer.json on Apple container"
    TOML
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/adevcontainer --version")
  end

  def caveats
    <<~EOS
      adevcontainer requires the Apple container CLI on the host (not installed by this formula):
        https://github.com/apple/container

      After upgrading Apple container, reinstall this formula so the
      `container dev` plugin is restaged:
        brew reinstall wcgomes/tap/adevcontainer

      If post_install cannot write /usr/local/libexec, restage with:
        sudo adevcontainer install-plugin

      After install, run:
        adevcontainer doctor
    EOS
  end
end
