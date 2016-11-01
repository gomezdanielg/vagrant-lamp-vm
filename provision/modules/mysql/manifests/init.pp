class mysql {

    require init

    $mysqlpw = "root"

    package { "mysql-server":
        ensure => "present"
    } ->

    file { "/etc/mysql/my.cnf":
        ensure => present,
    } ->

    file_line { "allow-remote-access":
        path => "/etc/mysql/my.cnf",
        line => "bind-address = 0.0.0.0",
        match   => "^bind-address.*$",
    } ~>

    service { "mysql":
        ensure => running
    } ->

    exec { "set-mysql-password":
        unless => "mysqladmin -uroot -p$mysqlpw status",
        command => "mysqladmin -uroot password $mysqlpw",
    } ->

    exec { "allow-remote-access":
        command => "/usr/bin/mysql -uroot -p$mysqlpw -e \"GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$mysqlpw' WITH GRANT OPTION;\"",
    }

}
