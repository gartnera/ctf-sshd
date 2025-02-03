#This challenge uses ssh to give users a vim shell. Build the sshd image first with docker build -t sshd ..

FROM ghcr.io/gartnera/ctf-sshd

#RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

#RUN userdel -r ctf

RUN apt install -y vim

RUN chsh -s /usr/bin/vim ctf
