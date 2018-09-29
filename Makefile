compose:
	docker-compose up -d

scale:
	@docker-compose scale server=5
