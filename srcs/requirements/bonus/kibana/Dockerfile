FROM	node:16

ARG	KIBANA_VERSION=7.17.25

RUN	apt-get update && apt-get upgrade -y && apt-get install -y \
	wget \
	tar \
	install-info \
	libpython3.7-stdlib \
	&& wget https://artifacts.elastic.co/downloads/kibana/kibana-$KIBANA_VERSION-linux-x86_64.tar.gz \
	&& tar -xzf kibana-$KIBANA_VERSION-linux-x86_64.tar.gz \
	&& mv kibana-$KIBANA_VERSION-linux-x86_64/ /usr/share/kibana \
	&& rm -rf /usr/share/kibana/kibana-$KIBANA_VERSION-linux-x86_64.tar.gz \
	&& apt-get clean

COPY	conf/kibana.yml usr/share/kibana/config/kibana.yml

WORKDIR	/usr/share/kibana

EXPOSE	5601

CMD	["bin/kibana", "--allow-root"]
