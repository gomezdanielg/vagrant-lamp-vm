class mysql {

    require init

    $mysqlpw = "root"

    package { "mysql-server":
        ensure => "present"
    } ->

    service { "mysql":
        ensure => running,
    } ->

    exec { "set-mysql-password":
        unless => "mysqladmin -uroot -p$mysqlpw status",
        command => "mysqladmin -uroot password $mysqlpw",
    }

}
