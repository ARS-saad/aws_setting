#!/bin/bash

set -e

echo "Starting Ansible configuration deployment..."

ansible-playbook -i hosts \
  install-kubectl-awscli.yml \
  instal_docker_build_server.yml \
  access_aws.yml \
  --ask-vault-pass

echo "All playbooks executed successfully!"
