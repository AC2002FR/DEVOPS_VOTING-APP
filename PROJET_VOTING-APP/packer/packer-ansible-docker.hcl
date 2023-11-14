build {
  sources = ["source.docker.ubuntu"]
  
  provisioner "ansible" {
    playbook_file       = "install-voting-app.yml"
    environment_vars    = ["ANSIBLE_PASSWORD=${{ secrets.ANSIBLE_PASSWORD }}"]
    ansible_env_vars    = ["ANSIBLE_HOST_KEY_CHECKING=False"]
    ansible_ssh_timeout = "20m"
  }

  post-processor "docker-tag" {
    repository = "ac2002/projet_voting-app"
    tag        = "latest"
  }
}

packer {
  required_plugins {
    docker = {
      version = ">= 1.7.0"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "ubuntu" {
  image = "ubuntu:latest"
}
