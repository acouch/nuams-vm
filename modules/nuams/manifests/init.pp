# Nuams puppet classes.
class nuams($webadminuser = "webadmin") {
  # Copy our git-sh deb package into the vm for ins
  file { "/etc/update-motd.d/10-help-text":
    owner => root,
    group => root,
    mode => 755,
    ensure => file,
    source => "puppet:///modules/nuams/10-help-text",
  }
  package { 'nuams-package':
    name => [
        'figlet',
      ],
      ensure => installed,
  }
  file { [ "/root/.ssh" ]:
    ensure => "directory",
    owner => 'root',
    group => 'root',
  }
  # Add exemption for github so nuams can be cloned.
  exec { 'root-ssh-config-github':
    cwd     => '/root/.ssh',
    command => "/bin/echo 'Host github.com\n\tStrictHostKeyChecking no\n' >> /root/.ssh/config",
    creates => '/root/.ssh/config',
    require => File["/root/.ssh"]
  }
  file { [ "/etc/drush" ]:
    ensure => "directory",
    owner => $webadminuser,
    group => $webadminuser,
  }
  file { [ "/etc/nuams" ]:
    ensure => "directory",
    owner => $webadminuser,
    group => $webadminuser,
    recurse => true,
  }
  file { "/home/$webadminuser/.drush":
    ensure => "directory",
    owner => $webadminuser,
    group => $webadminuser,
    recurse => true,
  }
  vcsrepo { "/home/$webadminuser/.drush/buck":
    ensure => present,
    provider => git,
    source => "http://git.drupal.org/project/buck.git",
  }
  vcsrepo { "/etc/nuams":
    ensure => present,
    provider => git,
    source => "git@github.com:nuams/nuams_drush.git",
    require => [File["/root/.ssh/id_dsa"], Exec['root-ssh-config-github']],
  }
  file { '/etc/drush/aliases.drushrc.php':
    ensure => 'link',
    target => '/etc/nuams/aliases.drushrc.php',
    require => [File["/etc/drush"], Vcsrepo["/etc/nuams"]],
  }
  file { "/root/.ssh/id_dsa":
      ensure => present,
      source => "puppet:///modules/nuams/id_dsa",
      owner => $webadminuser,
      group => $webadmingroup,
    }
}
