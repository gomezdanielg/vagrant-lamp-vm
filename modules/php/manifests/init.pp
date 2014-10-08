class php {

    require init

    $packages = [
        "php5",
        "php5-cli",
        "php5-mysql",
        "php5-curl",
        "php5-imagick",
        "php5-dev",
        "php5-xdebug",
        "php5-gd",
        "php5-mcrypt",
        "php-pear",
        "libapache2-mod-php5"
     ]

    package { $packages: 
        ensure => "present"
    }

}
