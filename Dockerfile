FROM python:3.8.3-alpine3.11

# Metadata params
ARG VERSION=2.9.9

# Metadata
LABEL maintainer="Mikhail Konyakhin <m.konyahin@gmail.com>" \
      org.label-schema.url="https://github.com/sportsru/docker-ansible-alpine/blob/master/README.md" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url="https://github.com/sportsru/docker-ansible-alpine.git" \
      org.label-schema.vcs-ref=$VERSION \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.description="Ansible on alpine docker image" \
      org.label-schema.schema-version="1.0"

RUN apk --update add \
        ca-certificates \
        git \
        openssh-client \
        openssl \
        rsync \
        sshpass \
        gcc \
        musl-dev \
        openldap-dev \
        libffi-dev
RUN apk --update add --virtual \
        .build-deps \
        libffi-dev \
        libressl-dev \
        build-base \
 && python -m pip install --upgrade \
        pip \
        cffi \
        PyNaCl\
 && python -m pip install \
        ansible==${VERSION} \
 && apk del \
        .build-deps \
 && rm -rf /var/cache/apk/*

RUN mkdir -p /etc/ansible \
 && echo 'localhost' > /etc/ansible/hosts \
 && echo -e """\
\n\
Host *\n\
    StrictHostKeyChecking no\n\
    UserKnownHostsFile=/dev/null\n\
""" >> /etc/ssh/ssh_config

COPY entrypoint /usr/local/bin/

WORKDIR /ansible

ENTRYPOINT ["entrypoint"]

# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]

