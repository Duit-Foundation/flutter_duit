.PHONY: cov

cov:
	fvm flutter test -j=10 --coverage && genhtml coverage/lcov.info --output=coverage/html && open coverage/html/index.html

.PHONY: test

test:
	fvm flutter test -j=10

.PHONY: lint

lint:
	fvm flutter analyze .

.PHONY: format

format:
	fvm dart format .
