require "formula"

class Jrnl < Formula
    homepage "http://maebert.github.io/jrnl/"
    url "https://github.com/maebert/jrnl/archive/1.9.3.tar.gz"
    sha1 "38091adba43ca77c438ddeb725efdf80243222dc"

    depends_on :python if MacOS.version <= :snow_leopard
    depends_on "pycrypto" => [:python, "Crypto"]

    def install
        ENV.prepend_create_path "PYTHONPATH", "#{libexec}/lib/python2.7/site-packages"
        system "python", "setup.py", "build"
        system "python", "setup.py", "install", "--prefix=#{libexec}"
        bin.install Dir[libexec/"bin/*"]
        bin.env_script_all_files(libexec+"bin", :PYTHONPATH => ENV["PYTHONPATH"])
    end

    test do
        system "#{bin}/jrnl", "-h"
        assert_equal 0, $?.exitstatus
    end
end
