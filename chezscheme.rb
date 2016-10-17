class Chezscheme < Formula
  desc "Chez Scheme"
  homepage "https://cisco.github.io/ChezScheme/"
  url "https://github.com/cisco/ChezScheme/archive/v9.4.tar.gz"
  sha256 "9f4e6fe737300878c3c9ca6ed09ed97fc2edbf40e4cf37bd61f48a27f5adf952"

  bottle do
    sha256 "c39e08f81b71f137507736173b48591f2e4988a0e4e9f7c39dccf13027eff86c" => :el_capitan
    sha256 "2ee8042075b3b5032ca3ff9f2024120432a60c221bc09632cc8d98b62c3fd2da" => :yosemite
    sha256 "39c50e48f35bec6715bf3046e17034b458c997766762c1dad665f78763025866" => :mavericks
  end

  depends_on :x11 => :build

  def install
    system "./configure",
              "--installprefix=#{prefix}",
              "--threads",
              "--installschemename=chez"
    system "make", "install"
  end

  test do
    (testpath/"hello.ss").write <<-EOS.undent
      (display "Hello, World!") (newline)
    EOS

    expected = <<-EOS.undent
      Hello, World!
    EOS

    assert_equal expected, shell_output("#{bin}/chez --script hello.ss")
  end
end
