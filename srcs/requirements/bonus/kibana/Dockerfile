FROM	node:16

ENV	ELASTICSEARCH_HOSTS=http://elasticsearch:9200

ARG	KIBANA_VERSION=8.7.1

RUN	apt-get update && apt-get upgrade -y && apt-get install -y \
	wget \
	tar \
	install-info \
	libpython3.7-stdlib \
	&& wget https://artifacts.elastic.co/downloads/kibana/kibana-$KIBANA_VERSION-linux-x86_64.tar.gz \
	&& tar -xzf kibana-$KIBANA_VERSION-linux-x86_64.tar.gz \
	&& mv kibana-$KIBANA_VERSION/ /usr/share/kibana \
	&& rm -rf /usr/share/kibana/kibana-$KIBANA_VERSION-linux-x86_64.tar.gz \
	&& apt-get clean

WORKDIR	/usr/share/kibana

EXPOSE	5601

CMD	["bin/kibana", "--allow-root"]
