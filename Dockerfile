FROM python:3.8.0b3-buster
WORKDIR /root/
RUN apt update && \
		apt upgrade -y && \
		apt install -y apt-utils
RUN apt install -y nodejs npm
RUN python3 -m pip install --no-cache-dir --upgrade pip
RUN git clone https://github.com/OWASP/SecureTea-Project securetea
RUN wget https://github.com/coder/code-server/releases/download/2.1472-vsc1.38.1/code-server2.1472-vsc1.38.1-linux-x86_64.tar.gz &&\
	tar --gzip -xf ./code-server2.1472-vsc1.38.1-linux-x86_64.tar.gz && \
	mv -f code-server2.1472-vsc1.38.1-linux-x86_64/* ~/ && \
	chmod +x ~/code-server
RUN apt install zsh gcc clang libnl-utils libnfnetlink-dev libnfnetlink0 libnl-cli-3-dev libnl-3-dev -y
RUN apt install -y build-essential python-dev libnetfilter-queue-dev
RUN apt -y install clamav 
RUN freshclam
RUN npm i -g @angular/cli typescript tslib tslint serve webpack parcel ts-node
WORKDIR /root/securetea
RUN pip install --no-cache-dir virtualenv && \
	virtualenv .env #pip install --no-cache-dir -r requirements.txt
EXPOSE 7171
RUN ~/code-server ./ --port 7171 --host 0.0.0.0
CMD zsh -l
