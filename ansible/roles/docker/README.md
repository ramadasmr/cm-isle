## `docker` role

Installs Docker Engine (Docker CE) on Ubuntu from Docker’s official apt repository.

### What it does

- Removes conflicting distro packages (optional)
- Adds Docker’s GPG key to `/etc/apt/keyrings/docker.asc`
- Adds Docker’s apt repository (deb822)
- Installs:
  - `docker-ce`, `docker-ce-cli`, `containerd.io`
  - `docker-buildx-plugin`, `docker-compose-plugin`
- Enables and starts the `docker` service

### Variables

- **`docker_ubuntu_remove_conflicting`**: remove conflicting packages (default `true`)
- **`docker_ubuntu_conflicting_packages`**: list of packages to remove
- **`docker_ubuntu_packages`**: list of Docker packages to install

