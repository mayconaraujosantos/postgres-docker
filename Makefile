make env-file:
	cp env.local .env
make up:
	docker-compose up -d 
make down:
	docker-compose down 
