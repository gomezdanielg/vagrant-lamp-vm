class mysql {

    require init

    $mysqlpw = "root"
    $mysql_remote_user = "zarego"
    $mysql_remote_user_password = "zarego"

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

    exec { "create-mysql-remote-user":
        unless => "/usr/bin/mysql -u$mysql_remote_user -p$mysql_remote_user_password",
        command => "/usr/bin/mysql -uroot -p$mysqlpw -e \"CREATE USER '$mysql_remote_user'@'%' IDENTIFIED BY '$mysql_remote_user_password'; GRANT ALL ON *.* TO '$mysql_remote_user'@'%';\"",
    }

}
