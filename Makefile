build:
	@docker build -t pedrocesarti/jmeter-docker:local .

build_all:
	@while read -r version ; do \
		docker build --build-arg JMETER_VERSION=$$version --tag pedrocesarti/jmeter-docker:$$version . ; \
		docker push pedrocesarti/jmeter-docker:$$version ; \
	done < VERSIONS
