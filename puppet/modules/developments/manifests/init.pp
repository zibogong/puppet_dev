class developments {
  package { [
    "autoconf",
    "automake",
    "cmake",
    "curl",
    "git",
    "g++",
    "libbost-all-dev",
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
    command => "/bin/bash bazel.sh > /var/log/puppet-bazel.log",
    timeout => 0,
  }

  Package <| |> -> Exec["protobuf"]
  exec {"protobuf":
    command => "/bin/bash protobuf.sh > /var/log/protobuf.log",
    creates => "/usr/local/include/google/message.h",    
    timeout => 0,
  }

  Package <| |> -> Exec["opencv"]
  exec {"opencv":
    command => "/bin/bash opencv.sh > /var/log/opencv.log",
    creates => "/usr/local/include/opencv/cv.h",
    timeout => 0,
  }
}
