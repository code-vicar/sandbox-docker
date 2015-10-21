# -*- mode: ruby -*-
# vi: set ft=ruby :


$script = <<SCRIPT
  bail() {
      echo Error executing command, exiting
      exit 1
  }

  exec_cmd() {
      if ! [[ "$2" == "-q" ]]
          then echo "Executing $1"
      fi

      sudo -n bash -c "$1" || bail
  }

  print_header() {
      echo ""
      echo "## $1 ##"
      echo ""
  }

  print_banner() {
      echo "############################################"
      echo "##            Install docker              ##"
      echo "##           and docker-compose           ##"
      echo "############################################"
  }

  # main
  print_banner

  print_header "Add docker PPA"
  exec_cmd "wget -qO- https://get.docker.io/gpg | apt-key add -"
  exec_cmd "echo deb http://get.docker.io/ubuntu docker main | tee /etc/apt/sources.list.d/docker.list"

  print_header "Install docker"
  exec_cmd "apt-get -q update && apt-get -qy install lxc-docker"

  print_header "Add vagrant user to docker group"
  exec_cmd "usermod -aG docker vagrant"

  print_header "Install docker-compose"
  exec_cmd "curl -sL https://github.com/docker/compose/releases/download/1.3.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
  exec_cmd "chmod +x /usr/local/bin/docker-compose"
SCRIPT


Vagrant.configure(2) do |config|
  config.vm.box = "phusion/ubuntu-14.04-amd64"

  config.vm.provision "shell", inline: $script

  config.vm.network "forwarded_port", guest: 8080, host: 8080
end
