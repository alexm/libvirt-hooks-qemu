class libvirt {
  package { 'ubuntu-virt':
    ensure  => installed,
    require => Exec['apt-get update'];
  }

  service { 'libvirt-bin':
    require => Package['ubuntu-virt'];
  }

  exec { 'apt-get update':
    command => '/usr/bin/sudo apt-get update';
  }

  $libvirt_files = [
    '/etc/libvirt/hooks/qemu',
    '/etc/libvirt/qemu/guest.xml',
    '/etc/libvirt/qemu/networks/default.xml'
  ]

  libvirt::file { $libvirt_files: }
}

define libvirt::file() {
  file { $name:
    ensure  => present,
    content => template("libvirt${name}.erb"),
    require => Package['ubuntu-virt'],
    notify  => Service['libvirt-bin'];
  }
}
