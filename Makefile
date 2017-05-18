.PHONY: init-dev run shell test destroy migrate mysql

init-dev:
	cp settings.example.py settings.py
	cp celeryconfig.example.py celeryconfig.py
	mkdir -p mounts/mysql
	mkdir -p mounts/logs
	mkdir -p mounts/fakes3
	mkdir -p mounts/uploaded

run:
	docker-compose up -d

shell:
	docker exec -it mltshp_mltshp_1 bash

test:
	docker exec -it mltshp_mltshp_1 su ubuntu -c "cd /srv/mltshp.com/mltshp; python test.py $(TEST)"

destroy:
	docker-compose down
	rm -rf mounts

migrate:
	docker exec -it mltshp_mltshp_1 su ubuntu -c "cd /srv/mltshp.com/mltshp; python migrate.py"

mysql:
	docker exec -it mltshp_mltshp_1 su ubuntu -c "cd /srv/mltshp.com/mltshp; mysql -u root --host mysql mltshp"
