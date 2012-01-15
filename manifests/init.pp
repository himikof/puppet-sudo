# Class: sudo
#
# Actions:
#  Install sudo and set up basics
#
# Depends:
#
class sudo {
  package { "sudo": }

  # Setup /etc/sudoers for .d inclusion 
  file {
    "/etc/sudoers.d/":
      ensure  => directory,
      recurse => true,
      purge   => true,
      mode    => 440;
    "/etc/sudoers":
      source  => "puppet:///modules/sudo/sudoers",
      owner   => "root",
      group   => "root",
      mode    => 440,
      require => Package["sudo"];
  }
}

# Define: sudo::rule
#
# Parameters:
#  entity
#    The user or group that can use the rule
#  command
#    The command that can be run
#  as_user
#    The user the command can be ran as
#  password_required
#    Is entering a password required? Defaults to true
#  comment
#    Optional comment, if none is supplied the resource name will be used
#  preserve_env_vars
#    Do the environment vars need to be preserved? Defaults to false
#
# Actions:
#  Set up a sudo rule
#
# Depends:
#  sudo
#
define sudo::rule($entity, $command, $as_user, $password_required = true, $comment = false, $preserve_env_vars=false) {
  include sudo
  $safe_name = regsubst($name, ' ', '_', 'G')

  $the_comment = $comment ? {
    false   => $name,
    default => $comment,
  }

  file { "/etc/sudoers.d/${safe_name}":
    content => template("sudo/sudo"),
    mode    => 440;
  }
}

