FROM ubuntu:noble

RUN apt update && apt install -y \
    openssh-server \
    {{ jre_package }} \
    git \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -mU -d /home/jenkins -s /bin/bash -G sudo jenkins \
    && echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/jenkins

RUN mkdir -p /run/sshd /home/jenkins/.ssh \
    && chown -R jenkins:jenkins /home/jenkins/.ssh \
    && chmod 700 /home/jenkins/.ssh

# Запуск SSH
USER jenkins

WORKDIR /home/jenkins

RUN mkdir -p ~/.ssh && touch ~/.ssh/authorized_keys \
    && echo "{{ master_public_key }}" >> ~/.ssh/authorized_keys

USER root

CMD ["/usr/sbin/sshd", "-D", "-p", "{{ ssh_slave_listening_port }}"]
