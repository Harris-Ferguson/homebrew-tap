class Paperclone < Formula
  desc "Menu-bar app that lays a subtle paper-texture overlay over the screen"
  homepage "https://github.com/Harris-Ferguson/paperclone"
  url "https://github.com/Harris-Ferguson/paperclone/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "95effc14d87368635f927db9b186d03802bad0515d31abcc07f7e67ec5841256"
  license "MIT"

  depends_on macos: :ventura

  def install
    system "bash", "build.sh"
    prefix.install "build/PaperClone.app"
    (bin/"paperclone").write <<~SH
      #!/bin/sh
      exec open "#{opt_prefix}/PaperClone.app" "$@"
    SH
  end

  def caveats
    <<~EOS
      Launch with:
        paperclone

      To see it in Launchpad and Finder's Applications folder:
        ln -sf "#{opt_prefix}/PaperClone.app" /Applications/
    EOS
  end

  test do
    app = prefix/"PaperClone.app"
    assert_path_exists app/"Contents/MacOS/PaperClone"
    assert_equal "io.github.harris-ferguson.paperclone",
      shell_output("/usr/libexec/PlistBuddy -c 'Print CFBundleIdentifier' #{app}/Contents/Info.plist").strip
  end
end
