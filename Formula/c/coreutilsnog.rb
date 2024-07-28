class Coreutilsnog < Formula
  desc "GNU File, Shell, and Text utilities"
  homepage "https://www.gnu.org/software/coreutils/"
  url "https://ftp.gnu.org/gnu/coreutils/coreutils-9.5.tar.xz"
  mirror "https://ftpmirror.gnu.org/coreutils/coreutils-9.5.tar.xz"
  sha256 "cd328edeac92f6a665de9f323c93b712af1858bc2e0d88f3f7100469470a1b8a"
  license "GPL-3.0-or-later"

  head do
    url "https://git.savannah.gnu.org/git/coreutils.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "bison" => :build
    depends_on "gettext" => :build
    depends_on "texinfo" => :build
    depends_on "wget" => :build
    depends_on "xz" => :build
  end

  depends_on "gmp"
  uses_from_macos "gperf" => :build

  on_linux do
    depends_on "attr"
  end

  conflicts_with "aardvark_shell_utils", because: "both install `realpath` binaries"
  conflicts_with "b2sum", because: "both install `b2sum` binaries"
  conflicts_with "ganglia", because: "both install `gstat` binaries"
  conflicts_with "gfold", because: "both install `gfold` binaries"
  conflicts_with "idutils", because: "both install `gid` and `gid.1`"
  conflicts_with "md5sha1sum", because: "both install `md5sum` and `sha1sum` binaries"

  def install
    system "./bootstrap" if build.head?

    args = %W[
      --prefix=#{prefix}
      --with-libgmp
      --without-selinux
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    (testpath/"test").write("test")
    (testpath/"test.sha1").write("a94a8fe5ccb19ba61c4c0873d391e987982fbbd3 test")
    system bin/"sha1sum", "-c", "test.sha1"
    system bin/"ln", "-f", "test", "test.sha1"
  end
end
