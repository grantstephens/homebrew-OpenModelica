# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/homebrew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Openmodelica < Formula
  desc "OpenModelica is an open-source Modelica-based modeling and simulation environment intended for industrial and academic usage."
  homepage "https://openmodelica.org/"
  url "https://github.com/RexFuzzle/OpenModelica/releases/download/v1.9.3/OpenModelica_v1.9.3_Complete.tar.gz"
  version "v1.9.3"
  sha256 "aa31b385b16678e20dd1cb85579eba0c27e78164886fc6ecd51543110237345b"
  head "https://github.com/OpenModelica/OpenModelica.git", :revision => "c3dd385ae1d2e287aa3acce84a97917e427e32ad"
                                         # or :branch => "develop"
                                         # or :tag => "1_0_release",
                                         #    :branch => "v1.9.3"
  depends_on "autoconf"
  depends_on "gettext"
  depends_on "liblas"
  depends_on "lapack"
  depends_on "omniorb"
	depends_on "qt4"
  depends_on "boost"
  depends_on "lp_solve"
  depends_on "cmake"
  depends_on "hdf5"
  depends_on "readline"
  depends_on "sundials"
  depends_on "gnu-sed"
  depends_on "xz"
  depends_on "libtool"
  depends_on "ncurses"
  depends_on "automake"
  conflicts_with "hwloc", :because => "Causes issues in compiling. Can be reinstalled afterwards again"
	conflicts_with "open-mpi", :because => "Causes issues in compiling. Can be reinstalled afterwards again"

  def install
    ENV['CFLAGS']='-I/usr/local/opt/gettext/include -I /usr/local/Cellar/lp_solve/5.5.2.0/bin'
    ENV['LDFLAGS']='-L/usr/local/opt/gettext/lib -L/usr/local/Cellar/lp_solve/5.5.2.0/lib'
    system "svn ls https://openmodelica.org/svn/OpenModelica --non-interactive --trust-server-cert"
    system "autoconf"
    system "./configure", "--disable-debug",
                          "--with-omniORB",
                          "--disable-omnotebook",
                          "--disable-modelica3d",
                          "--without-paradiseo",
                          "--disable-paramodelica",
                          "--disable-omplot",
                          "--prefix=#{prefix}"
    system "make -j6 omc"
    system "make -j6 omlibrary-all"
    # system "(cd testsuite/partest && ./runtests.pl)"
    prefix.install Dir["build/*"]
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test OpenModelica`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
