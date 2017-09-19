FROM ubuntu:17.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y openssh-server ruby ruby-dev build-essential libncurses5-dev libncurses5-dev && \
    mkdir /var/run/sshd

# bbs gem dependendencies
RUN gem install rurses tty figlet

# allow passwordless login
RUN echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config && \
    sed -i 's/nullok_secure/nullok/' /etc/pam.d/common-auth

# add user, without password, bbs as shell
RUN useradd -m bbs -s '/bin/bash' && \
    passwd -d bbs && \
    usermod bbs -s /home/bbs/robbs/bin/robbs

# don't show anything on login
RUN echo "PrintMotd no" >> /etc/ssh/sshd_config && \
    echo "PrintLastLog no" >> /etc/ssh/sshd_config && \
    sed -i 's|session    optional     pam_motd.so  motd=/run/motd.dynamic||' /etc/pam.d/sshd && \
    mkdir /home/bbs/.cache/ && touch /home/bbs/.cache/motd.legal-displayed

EXPOSE 22
CMD ["/usr/sbin/sshd", "-De"]
