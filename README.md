# Docker-Ansible base image

[![Layers](https://images.microbadger.com/badges/image/sportsru/ansible-alpine.svg)](https://microbadger.com/images/sportsru/ansible-alpine) [![GitHub issues](https://img.shields.io/github/issues/sportsru/docker-ansible-alpine.svg)](https://github.com/sportsru/docker-ansible-alpine) [![Docker Automated build](https://img.shields.io/docker/automated/sportsru/ansible-alpine.svg?maxAge=2592000)](https://hub.docker.com/r/sportsru/ansible-alpine/) [![Docker Build Status](https://img.shields.io/docker/build/sportsru/ansible-alpine.svg?maxAge=2592000)](https://hub.docker.com/r/sportsru/ansible-alpine/) [![Docker Pulls](https://img.shields.io/docker/pulls/sportsru/ansible-alpine.svg)](https://hub.docker.com/r/sportsru/ansible-alpine/)

## Usage

### Environnement variable

| Variable             | Default Value    | Usage                                       |
|----------------------|------------------|---------------------------------------------|
| PIP_REQUIREMENTS     | requirements.txt | install python library requirements         |
| ANSIBLE_REQUIREMENTS | galaxy.yml       | install ansible galaxy roles requirements   |
| DEPLOY_KEY           |                  | pass an SSH private key to use in container |

### Run Playbook

```
docker run -it --rm \
  -v ${PWD}:/ansible \
  sportsru/ansible-alpine:latest \
  ansible-playbook -i inventory playbook.yml
```

### Generate Base Role structure

```
docker run -it --rm \
  -v ${PWD}:/ansible \
  sportsru/ansible-alpine:latest \
  ansible-galaxy init role-name
```

### Lint Role

```
docker run -it --rm sportsru/ansible-alpine:latest \
  -v ${PWD}:/ansible ansible-playbook tests/playbook.yml --syntax-check
```
### Run with forwarding ssh agent

```
docker run -it --rm \
  -v $(readlink -f $SSH_AUTH_SOCK):/ssh-agent \
  -v ${PWD}:/ansible \
  -e SSH_AUTH_SOCK=/ssh-agent \
  sportsru/ansible-alpine:latest \
  sh
```

