
all: lint test

test:
	@echo "=== Testing module ==="
	make -C test test

lint:
	@echo "=== Linting module ==="
	terraform fmt -check -recursive .

.PHONY: all test lint
