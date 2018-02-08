FROM alpine:3.6

ENV ANSIBLE_VERSION 2.4.2.0

ENV BUILD_PACKAGES \
  ansible \
  bash \
  curl \
  tar \
  openssh-client \
  sshpass \
  git \
  gmp \
  python \
  py-boto \
  py-dateutil \
  py-httplib2 \
  py-jinja2 \
  py-paramiko \
  py-pip \
  py-setuptools \
  py-yaml \
  py2-crypto \
  ca-certificates

RUN apk --update add --virtual build-dependencies \
  gcc \
  musl-dev \
  libffi-dev \
  openssl-dev \
  ansible \
  python-dev

# If installing ansible@testing
#RUN \
#	echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> #/etc/apk/repositories

RUN set -x && \
    apk update && apk upgrade && \
    apk add --no-cache ${BUILD_PACKAGES} && \
    pip install --upgrade pip && \
    pip install python-keyczar docker-py && \
    # Cleaning up
    apk del build-dependencies && \
  	rm -rf /var/cache/apk/*

RUN \
  mkdir -p /etc/ansible/ /ansible

RUN \
  echo "[local]" >> /etc/ansible/hosts && \
  echo "localhost" >> /etc/ansible/hosts

RUN \
  curl -fsSL https://releases.ansible.com/ansible/ansible-${ANSIBLE_VERSION}.tar.gz -o ansible.tar.gz && \
  tar -xzf ansible.tar.gz -C /ansible --strip-components 1 && \
  rm -fr ansible.tar.gz /ansible/docs /ansible/examples /ansible/packaging

ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PYTHONPATH /ansible/lib
ENV PATH /ansible/bin:$PATH
ENV ANSIBLE_LIBRARY /ansible/library

WORKDIR /ansible/playbooks

COPY id_rsa_quelab /root/id_rsa_quelab
RUN chmod 600 /root/id_rsa_quelab

COPY .vault_pass /root/.vault_pass
RUN chmod 600 /root/.vault_pass

# ENTRYPOINT ["ansible-playbook"]
