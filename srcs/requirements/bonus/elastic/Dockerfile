FROM	ubuntu:20.04

ENV	DEBIAN_FRONTENT=noninteractive

RUN	apt-get update && \
	apt-get install -y --no-install-recommends \
	openjdk-8-jdk \
	software-properties-common \
	apt-transport-https \
	curl \
	gnupg2 && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

ENV	ES_JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

RUN	curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
    	add-apt-repository "deb https://artifacts.elastic.co/packages/7.x/apt stable main" && \
    	apt-get update && \
    	apt-get install -y --no-install-recommends elasticsearch

RUN	groupadd -g 1000 elasticsearch || true && useradd elasticsearch -u 1000 -g 1000 || true

WORKDIR	/usr/share/elasticsearch

RUN	set -ex && for path in data logs config config/scripts; do \
        mkdir -p "$path"; \
        chown -R elasticsearch:elasticsearch "$path"; \
    done

COPY	tools/logging.yml /usr/share/elasticsearch/config/
COPY	tools/elasticsearch.yml /usr/share/elasticsearch/config/

EXPOSE	9200

USER	elasticsearch

ENV	PATH=$PATH:/usr/share/elasticsearch/bin

CMD	["elasticsearch"]
