class Clusterit < Formula
  desc "Tools to turn UNIX workstations into speedy parallel beasts"
  homepage "http://www.garbled.net/clusterit.html"
  url "https://downloads.sourceforge.net/project/clusterit/clusterit/clusterit-2.5/clusterit-2.5.tar.gz"
  sha256 "e50597fb361d9aefff0250108900a3837a4a14c46083d6eb5ed5d7fc42ce9f35"

  bottle do
    cellar :any_skip_relocation
    sha256 "566ccf9d65e0cc4a3a04d4c6d15ebbf4829b92688142c9f1b9f38fd835f7c305" => :el_capitan
    sha256 "374a73eab22211e6df8460c1826a31afe4522861bf3d7bfeb13ec7a3fdb1f133" => :yosemite
    sha256 "4e5e4239e7dc5e9e0f52dbc84b4190693132b5b327acd7e3beba11e46208c831" => :mavericks
  end

  depends_on :x11

  conflicts_with "couchdb-lucene", :because => "both install a `run` binary"
  conflicts_with "pdsh", :because => "both install `dshbak`"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"

    # `run` is too generic a name to be placed in top-level bin.
    mv bin/"run", bin/"clusterit-run"
  end

  def caveats; <<-EOS.undent
    The `run` executable was installed as `clusterit-run` to avoid
    putting a generically-named executable in the top-level prefix.
  EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/barrierd -v")
  end
end
