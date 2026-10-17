class Turbocrypt < Formula
  desc "Fast file, directory, and Git encryption"
  homepage "https://github.com/jedisct1/turbocrypt"
  url "https://github.com/jedisct1/turbocrypt/releases/download/0.9.8/turbocrypt_0.9.8_darwin_all.tar.gz"
  sha256 "33227a80eb9de4f8a503fa0fc4573efdf030cba6ca26c04ec324f3bbacf24da3"
  license all_of: ["MIT", "LGPL-2.1-only"]

  depends_on :macos

  on_macos do
    depends_on macos: :ventura
  end

  def install
    bin.install "turbocrypt"
  end

  def caveats
    <<~EOS
      To use `turbocrypt mount`, install fuse-t:
        brew install --cask fuse-t
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/turbocrypt version 2>&1")
    (testpath/"plain.txt").write "Homebrew encryption test\n"
    system bin/"turbocrypt", "keygen", "test.key"
    system bin/"turbocrypt", "encrypt", "--key", "test.key", "plain.txt", "encrypted"
    system bin/"turbocrypt", "decrypt", "--key", "test.key", "encrypted", "restored.txt"
    assert_equal (testpath/"plain.txt").read, (testpath/"restored.txt").read
  end
end
