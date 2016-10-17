class Cwm < Formula
  desc "Portable version of OpenBSD's cwm(1) window manager"
  homepage "https://github.com/chneukirchen/cwm"
  head "https://github.com/chneukirchen/cwm.git"

  stable do
    url "https://github.com/chneukirchen/cwm/archive/v5.6.tar.gz"
    sha256 "006320bb1716cc0f93bac5634dcccd01f21d468263b5fc9d1be2dd11078a0625"

    patch do
      # Fix 10.10 build. Merged upstream.
      url "https://github.com/chneukirchen/cwm/commit/81c05b3.diff"
      sha256 "d801f8536885bdda82f724b6b30c26af5e8967490e1c0b6419933b2341688db4"
    end
  end

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "86b35fa5552b122e49569856979e103308111aac4ee88bbd10a281ee508d2961" => :el_capitan
    sha256 "bf394fe2acc18890e1cb3b42b80a8f1f5f494cc5c01d83a6a6d1a4fa342c17b2" => :yosemite
    sha256 "0af986635a49c77234a18f322c62826134463bed24c5d8283919c2d546d8673e" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on :x11

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end
end
