class Openmodelica < Formula
  desc "Open-source modeling and simulation tool"
  homepage "https://openmodelica.org/"
  url "https://github.com/OpenModelica/OpenModelica/releases/download/v1.9.5/openmodelica_1.9.5.tar.xz"
  sha256 "d9ed8ce13a764ed3ed36a52859f4d23e3f3fae0cf5af1fe4a9db4b9ba702d511"
  head do
    url "https://github.com/OpenModelica/OpenModelica.git"
    option "with-library", "Build with OMLibraries"
  end
  bottle do
    root_url "https://github.com/RexFuzzle/homebrew-OpenModelica/releases/download/v1.9.5"
    sha256 "81e5050f70edb2e4ff0580c6937801c9c9bffa6a2402bf4937524d8e05b900cc" => :el_capitan
  end

  depends_on "qt" =>:build
  depends_on "autoconf" =>:build
  depends_on "automake" =>:build
  depends_on "cmake" =>:build
  depends_on "gettext"
  depends_on "gnu-sed" =>:build
  depends_on "libtool" =>:build
  depends_on "homebrew/science/lp_solve"
  depends_on "openblas"
  depends_on "pkg-config" =>:build
  depends_on "readline" =>:build
  depends_on "xz" =>:build

  depends_on "omniorb" => :optional

  def install
    ENV["LDFLAGS"] = "-L#{Formula["openblas"].opt_lib}"
    ENV["CPPFLAGS"] = "-I#{Formula["openblas"].opt_include}"
    args = %W[--disable-debug
              --with-lapack=-lopenblas
              --disable-modelica3d
              --prefix=#{prefix}
              --without-omlibrary]

    args << "--with-omniORB" if build.with? "omniorb"

    system "autoconf"
    system "./configure", *args
    system "make", "omc"
    if build.with? "library"
      system "svn", "ls", "https://openmodelica.org/svn/OpenModelica", "--non-interactive", "--trust-server-cert"
      system "svn", "ls", "https://svn.modelica.org/projects/Modelica_ElectricalSystems/InstantaneousSymmetricalComponents", "--non-interactive", "--trust-server-cert"
      system "make", "omlibrary-core"
    end
    prefix.install Dir["build/*"]
  end

  test do
    system "#{bin}/omc", "--version"
    (testpath/"test.mo").write <<-EOS.undent
    model test
    Real x;
    initial equation
    x = 10;
    equation
    der(x) = -x;
    end test;
    EOS
    (testpath/"test.mos").write <<-EOS.undent
    loadFile("test.mo");
    simulate(test);
    EOS
    system "#{bin}/omc", "test.mos"
    assert File.exist?("test_res.mat")
  end
end
