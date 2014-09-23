require "formula"

class Jrnl < Formula
  homepage "http://maebert.github.io/jrnl/"
  url "https://github.com/maebert/jrnl/archive/1.9.3.tar.gz"
  sha1 "38091adba43ca77c438ddeb725efdf80243222dc"

  depends_on :python if MacOS.version <= :snow_leopard

  resource 'pycrypto' do
    url 'https://pypi.python.org/packages/source/p/pycrypto/pycrypto-2.6.tar.gz'
    sha1 'c17e41a80b3fbf2ee4e8f2d8bb9e28c5d08bbb84'
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", "#{libexec}/lib/python2.7/site-packages"
    install_args = ["setup.py", "install", "--prefix=#{libexec}"]

    resource("pycrypto").stage { system "python", *install_args }

    system "python", *install_args
    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec+"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  test do
    system "#{bin}/jrnl", "-h"
    assert_equal 0, $?.exitstatus
  end
end
