FROM ubuntu:24.04

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

ENV NOTVISIBLE="in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

#keyboard interactive method makes pam prompt for password instead of sshd
COPY sshd_config /etc/ssh/sshd_config

#modify ssh instead of common-auth so users can't su without password

# Don't check or prompt for password
RUN sed -i 's/@include common-auth/auth requisite pam_permit.so/' /etc/pam.d/sshd

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Don't print banner on login. Don't want to give away the challenge too easy
RUN sed -i '/pam_motd.so/s/^/#/' /etc/pam.d/sshd

RUN useradd -m -s /bin/bash ctf

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
