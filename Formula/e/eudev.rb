class Eudev < Formula
  desc "eudev is a standalone dynamic and persistent device naming support (aka userspace devfs) daemon that runs independently from the init system."
  homepage "https://github.com/eudev-project/eudev"
  url "https://github.com/eudev-project/eudev/releases/download/v3.2.14/eudev-3.2.14.tar.gz"
  sha256 "8da4319102f24abbf7fff5ce9c416af848df163b29590e666d334cc1927f006f"
  license "GPL-2.0-or-later"
  head "https://github.com/eudev-project/eudev", branch: "master"

  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "gperf" => :build
  depends_on "kmod"
  depends_on "libxslt"
  depends_on "libtool"
  depends_on "linux-headers@5.15" => :build
  depends_on "m4" => :build
  depends_on "gnu-sed" => :build
  depends_on "util-linux" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --cc=#{ENV.cc}
      --host-cflags=#{ENV.cflags}
      --host-ldflags=#{ENV.ldflags}
    ]
    
    system "./autogen.sh"
    system "./configure", *args
    system "make"
    system "make", "install"
  end
