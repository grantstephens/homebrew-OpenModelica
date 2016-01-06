# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/homebrew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Openmodelica < Formula
  desc "OpenModelica is an open-source Modelica-based modeling and simulation environment intended for industrial and academic usage."
  homepage "https://openmodelica.org/"
  # url "https://github.com/OpenModelica/OpenModelica/archive/v1.9.3.tar.gz"
  version "1.9.3"
  sha256 ""
  head "https://github.com/OpenModelica/OpenModelica.git", :branch => "v1.9.3"
                                         # or :branch => "develop"
                                         # or :tag => "1_0_release",
                                         #    :revision => "c3dd385ae1d2e287aa3acce84a97917e427e32ad"
  # depends_on "cmake" => :build
  depends_on :autoconf
  # depends_on "boost"
  depends_on "gettext"
  # depends_on "gcc"
  # depends_on "lp_solve"
  # depends_on "cmake"
  # depends_on "hdf5"
  # depends_on "readline"
  # depends_on "sundials"
  # depends_on "openblas"
  depends_on "liblas"
  depends_on "lapack"
  # depends_on "gnu-sed"
  # depends_on "open-mpi"
  depends_on "omniorb"
  # depends_on "libtool"
  # depends_on "subversion"
  # depends_on "ncurses"
  # depends_on "automake"
  # conflicts_with "hwloc", :because => "yellowduck also ships a duck binary"
  # depends_on "dyld-headers"
  # depends_on "cppunit"
  # depends_on "isl"
  # depends_on "mumps"
  # depends_on "git"
  # depends_on "suite-sparse"
  # depends_on ""

  # depends_on :gfortran
  # depends_on :x11 # if your formula requires any X11/XQuartz components

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # export PATH=/usr/local/Cellar/gettext/0.19.6/bin/
    # export LIBCURL_LDFLAGS=-L/usr/local/opt/gettext/lib -L/usr/local/Cellar/lp_solve/5.5.2.0/lib
    # export LIBCURL_CFLAGS=-I/usr/local/opt/gettext/include -I /usr/local/Cellar/lp_solve/5.5.2.0/bin
# ./configure LDFLAGS="-L/usr/local/opt/gettext/lib -L/usr/local/Cellar/lp_solve/5.5.2.0/lib" CFLAGS="-I/usr/local/opt/gettext/include -I /usr/local/Cellar/lp_solve/5.5.2.0/bin " CC=clang CXX=clang++ --without-omniORB --disable-omnotebook --disable-modelica3d --without-paradiseo --disable-paramodelica --disable-omplot -with-lapack=openblas
    # Remove unrecognized options if warned by configure
    ENV['CFLAGS']='-I/usr/local/opt/gettext/include -I /usr/local/Cellar/lp_solve/5.5.2.0/bin'
    ENV['LDFLAGS']='-L/usr/local/opt/gettext/lib -L/usr/local/Cellar/lp_solve/5.5.2.0/lib'
    # ENV['PATH']='$PATH:/usr/local/Cellar/gettext/0.19.6/bin/'
    # system "PATH=$PATH:/usr/local/Cellar/gettext/0.19.6/bin/"
    system "git submodule update"
    # system "make gitclean"
    system "autoconf"
    # system "mkdir libraries"
    system "./configure", "--disable-debug",
                          "--with-omniORB",
                          "--disable-omnotebook",
                          "--disable-modelica3d",
                          "--without-paradiseo",
                          "--disable-paramodelica",
                          "--disable-omplot"
                          # "--disable-dependency-tracking",
                          # "--disable-silent-rules",
                          # "--prefix=#{prefix}",
                          # "--with-lapack=openblas"
    # system "cmake", ".", *std_cmake_args
    system "make -j6 omc"
    system "make -j6 omlibrary-all"
    system "(cd testsuite/partest && ./runtests.pl)"
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
