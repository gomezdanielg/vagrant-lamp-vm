class apache2 {

    require init

    package { "apache2":
        ensure => "present"
    } ->

    file { "/etc/apache2/mods-enabled/rewrite.load":
        ensure => link,
        target => "/etc/apache2/mods-available/rewrite.load",
    } ->

    file { "/etc/apache2/sites-enabled":
        ensure => directory,
        recurse => true,
        purge => true,
        force => true
    } ->

    file { "/etc/apache2/sites-available/webroot.conf":
        ensure => present,
        source => "/vagrant/modules/apache2/manifests/webroot.conf"
    } ->

    file { "/etc/apache2/sites-enabled/webroot.conf":
        ensure => link,
        target => "/etc/apache2/sites-available/webroot.conf"
    } ~>
    
    service { "apache2":
        ensure => running
    }

}
