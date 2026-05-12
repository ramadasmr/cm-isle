#!/usr/bin/env bash
set -euo pipefail

# Creates:
# - mp-master (Ubuntu): installs ansible + salt-master
# - mp-ubuntu1 (Ubuntu): installs salt-minion
#
# This is intentionally Ubuntu-only; see README for Rocky/Alma notes.

launch() {
  local name="$1"
  multipass launch ubuntu:24.04 --name "${name}" --cpus 2 --memory 2G --disk 20G
}

launch mp-master
launch mp-ubuntu1

multipass exec mp-master -- sudo apt-get update
multipass exec mp-master -- sudo apt-get install -y ansible salt-master
multipass exec mp-master -- sudo systemctl enable --now salt-master

multipass exec mp-ubuntu1 -- sudo apt-get update
multipass exec mp-ubuntu1 -- sudo apt-get install -y salt-minion

master_ip="$(multipass info mp-master | awk '/IPv4/{print $2; exit}')"
multipass exec mp-ubuntu1 -- sudo sh -c "printf '%s\n' 'master: ${master_ip}' >/etc/salt/minion.d/master.conf"
multipass exec mp-ubuntu1 -- sudo systemctl enable --now salt-minion

echo
echo "Instances:"
multipass list
echo
echo "Shell into master:"
echo "  multipass shell mp-master"

