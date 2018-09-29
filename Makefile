compose:
	@docker-compose up -d

scale:
	@docker-compose scale server=5

build:
	@while read -r version ; do \
		docker build --build-arg JMETER_VERSION=$$version --tag pedrocesarti/jmeter-docker:$$version . ; \
		docker push pedrocesarti/jmeter-docker:$$version ; \
	done < versions.txt
