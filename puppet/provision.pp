# ===
# Install and Run MongoDB Server
# ===

$mongodbPack = "https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.6.5.tgz"
$splitter0 = split($mongodbPack, '/')
$mongodbFile = $splitter0[-1]

# Create a directories
file { "/vagrant/mongo":
  ensure => "directory",
  before => Exec['mongo-download'],
}

file { "/data/db":
  ensure => "directory",
  before => Exec['mongo-download'],
}

# Download Mongo
exec { "mongo-download": 
  command => "/usr/bin/wget $mongodbPack",
  cwd => "/vagrant/mongo",   
  creates => "/vagrant/mongo/$mongodbFile",
  before => Package['mongo-extract'],
  timeout => 0
}

# Extract Mongo
exec {"mongo-extract": 
  command => "tar xvzf $mongodbFile -C /mongodb",
  cwd => "/vagrant/mongo",   
  creates => "/mongodb",
  path    => ["/usr/bin", "/usr/sbin", "/bin"]
}

