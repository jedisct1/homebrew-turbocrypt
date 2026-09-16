class Turbocrypt < Formula
  desc "Fast file, directory, and Git encryption"
  homepage "https://github.com/jedisct1/turbocrypt"
  url "https://github.com/jedisct1/homebrew-turbocrypt/releases/download/0.9.5/turbocrypt_0.9.5_macos_universal.tar.gz"
  version "0.9.5"
  sha256 "aae2663723b7a0ff1567f01f5247e47b252d6cee9df68c878280f31f2248889a"
  license all_of: ["MIT", "LGPL-2.1-only"]

  depends_on :macos

  on_macos do
    depends_on macos: :ventura
  end

  # Preserve the upstream Developer ID signature.
  skip_clean "bin/turbocrypt"

  def install
    bin.install "turbocrypt"
    bash_completion.install "shell-completion/bash/turbocrypt"
    zsh_completion.install "shell-completion/zsh/_turbocrypt"
    fish_completion.install "shell-completion/fish/turbocrypt.fish"
    pkgshare.install "source", "BUILD-INFO.json"
  end

  def post_install
    system "/usr/bin/codesign", "--verify", "--strict", "--all-architectures",
           "-R", '=anchor apple generic and identifier "org.pureftpd.turbocrypt" and certificate leaf[subject.OU] = "888H8YF752" and certificate leaf[field.1.2.840.113635.100.6.1.13] exists', bin/"turbocrypt"
  end

  def caveats
    <<~EOS
      To use `turbocrypt mount`, install fuse-t:
        brew install --cask fuse-t
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/turbocrypt version 2>&1")
    system "/usr/bin/codesign", "--verify", "--strict", "--all-architectures",
           "-R", '=anchor apple generic and identifier "org.pureftpd.turbocrypt" and certificate leaf[subject.OU] = "888H8YF752" and certificate leaf[field.1.2.840.113635.100.6.1.13] exists', bin/"turbocrypt"
    (testpath/"plain.txt").write "Homebrew encryption test\n"
    system bin/"turbocrypt", "keygen", "test.key"
    system bin/"turbocrypt", "encrypt", "--key", "test.key", "plain.txt", "encrypted"
    system bin/"turbocrypt", "decrypt", "--key", "test.key", "encrypted", "restored.txt"
    assert_equal (testpath/"plain.txt").read, (testpath/"restored.txt").read
  end
end
