FROM	node:16

ENV	ELASTICSEARCH_HOSTS=http://elasticsearch:9200

ARG	KIBANA_VERSION=8.10.0

RUN	apt-get update && apt-get install -y \
	wget \
	tar \
	&& wget https://artifacts.elastic.co/downloads/kibana/kibana-$KIBANA_VERSION-linux-x86_64.tar.gz \
	&& tar -xzf kibana-$KIBANA_VERSION-linux-x86_64.tar.gz \
	&& mv kibana-$KIBANA_VERSION-linux-x86_64.tar.gz /usr/share/kibana \
	&& rm kibana-$KIBANA_VERSION-linux-x86_64.tar.gz \
	&& apt-get remove -y wget tar \
	&& apt-get autoremove -y \
	&& apt-get clean

WORKDIR	/usr/share/kibana

EXPOSE	5601

CMD	["bin/kibana"]
