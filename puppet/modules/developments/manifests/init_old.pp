class developments {
  package { [
    "autoconf",
    "automake",
    "cmake",
    "curl",
    "git",
    "g++",
    "libgflags-dev",
    "libgoogle-glog-dev",
    "libtool",
    "python-pip",
    "pylint",
    "openjdk-8-jdk",
    ]:
    ensure=>"latest";
  }

  define install_py_pkg ($pkgname, $module_to_test_import) {
    exec {
      "InstallPyPkg_$pkgname":
      path => ["/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/"],
      command => "pip install $pkgname",
      unless => "/usr/bin/python2.7 -c 'import $module_to_test_import'",
    }
  }

  install_py_pkg {
    "cpplint":
    pkgname => cpplint,
    module_to_test_import => "cpplint";
  }
 
  Package <| |> -> Exec["bazel"]
  exec {"bazel":
    #path => "./",
    command => "/bin/bash bazel.sh > /var/log/puppet-bazel.log",
    #creates => TODO
  }

  package {
    "bazel":
    ensure => "latest",
  }

  Package <| |> -> Exec["gflags"]
  exec {"gflags":
    #path=>"./",
    command => "/bin/bash gflags.sh > /var/log/puppet-gflags.log",
    creates => "/usr/local/include/gflags/gflags.h",
  }

  Package <| |> -> Exec["glog"]
  exec {"glog":
    #path=>"./",
    command => "/bin/bash glog.sh > /var/log/puppet-glog.log",
    creates => "/usr/local/include/glog/logging.h",
    #require => Exec["gflags"];
  }
}
