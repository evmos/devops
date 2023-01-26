build: stop
	@while [ -z "$$REPO" ]; do \
	read -r -p "Repository [evmos/ethermint]: " REPO; \
	done; \
	if [ $$REPO != "evmos" ] && [ $$REPO != "ethermint" ]; \
	then \
		echo "Invalid repo. Using default (evmos)"; \
		REPO=evmos; \
	fi; \
	echo "Building single-node setup with $$REPO ..."; \
	docker build --no-cache --tag single-node1 .  --build-arg repo=$$REPO --build-arg commit_hash=$(shell bash -c 'read -p "Version or Commit Hash for 1st node: " version; echo $$version') --build-arg extra_flags=$(shell bash -c 'read -p "Extra flags: " flags; echo $$flags') --build-arg USERNAME=$$USER; \
	docker build --no-cache --tag single-node2 .  --build-arg repo=$$REPO --build-arg commit_hash=$(shell bash -c 'read -p "Version or Commit Hash for 2nd node: " version; echo $$version') --build-arg extra_flags=$(shell bash -c 'read -p "Extra flags: " flags; echo $$flags') --build-arg USERNAME=$$USER; \

start: stop
	docker-compose -f ./docker-compose.yml up --build -d

stop:
	docker-compose -f ./docker-compose.yml down -v
