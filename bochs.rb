class Bochs < Formula
  desc "Open source IA-32 (x86) PC emulator written in C++"
  homepage "http://bochs.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/bochs/bochs/2.6.8/bochs-2.6.8.tar.gz"
  sha256 "79700ef0914a0973f62d9908ff700ef7def62d4a28ed5de418ef61f3576585ce"

  bottle do
    revision 1
    sha256 "7a878fc87417ea5f4b06df5656be1c6253f96c41b71462e4a7d7cc082b568171" => :el_capitan
    sha256 "6cca6060571b03cd4981c0938b8ed0db66e8e8c464e4eb24f8bb2f82e9ee877a" => :yosemite
    sha256 "93613f9e68caedc20b4ae3ea3b5ea7b1e5b4450e8c1319cdd3a5e364111fd67c" => :mavericks
  end

  option "with-gdb-stub", "Enable GDB Stub"

  depends_on "pkg-config" => :build
  depends_on :x11
  depends_on "gtk+"

  def install
    args = %W[
      --prefix=#{prefix}
      --with-x11
      --with-nogui
      --enable-disasm
      --disable-docbook
      --enable-x86-64
      --enable-pci
      --enable-all-optimizations
      --enable-plugins
      --enable-cdrom
      --enable-a20-pin
      --enable-fpu
      --enable-alignment-check
      --enable-large-ramfile
      --enable-debugger-gui
      --enable-readline
      --enable-iodebug
      --enable-xpm
      --enable-show-ips
      --enable-logging
      --enable-usb
      --enable-ne2000
      --enable-cpu-level=6
      --enable-sb16
      --enable-clgd54xx
      --with-term
      --enable-ne2000
    ]

    if build.with? "gdb-stub"
      args << "--enable-gdb-stub"
    else
      args << "--enable-debugger"
    end

    system "./configure", *args

    system "make"
    system "make", "install"
  end

  test do
    system bin/"bochs", "--help"
  end
end
