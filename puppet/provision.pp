# ===
# Install and Run MongoDB Server
# ===


# Import the public key used by the package management system
exec { "mongo-pk": 
  command => "sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10",
  cwd => "/vagrant",   
  before => Exec['mongo-list-file'],
  path    => ["/usr/bin", "/usr/sbin", "/bin"]
}

# Create a list file for MongoDB.
exec {"mongo-list-file": 
  command => "echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list",
  cwd => "/vagrant",
  path    => ["/usr/bin", "/usr/sbin", "/bin"],
  before => Exec['mongo-reload']
}

# Reload local package database.
exec {"mongo-reload": 
  command => "sudo apt-get update",
  cwd => "/vagrant", 
  path    => ["/usr/bin", "/usr/sbin", "/bin"],
  before => Exec['mongo-install']
}

notify {"Installing":
  message => "Installing MongoDB.. PLEASE WAIT",
  require => Exec["mongo-reload"],
  before => Exec['mongo-install']
}

# Install the MongoDB packages.
exec {"mongo-install": 
  command => "sudo apt-get install -y mongodb-org",
  cwd => "/vagrant", 
  path    => ["/usr/bin", "/usr/sbin", "/bin"],
  before => Exec['mongo-start']
}

# Start MongodDB
exec {"mongo-start": 
  command => "sudo service mongod start",
  cwd => "/vagrant",
  path    => ["/usr/bin", "/usr/sbin", "/bin"],
  before => Exec['mongo-check']
}

# Check MongodDB has started
exec {"mongo-check": 
  command => "cat /var/log/mongodb/mongod.log",
  cwd => "/vagrant",
  path    => ["/usr/bin", "/usr/sbin", "/bin"]
}

