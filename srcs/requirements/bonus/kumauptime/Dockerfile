FROM	node:20-bullseye

WORKDIR	/app

RUN	git clone https://github.com/louislam/uptime-kuma.git /app

RUN	npm install --include=dev
RUN	npm run build

VOLUME	["/app/data"]

EXPOSE	3001

CMD	["node", "server/server.js"]
