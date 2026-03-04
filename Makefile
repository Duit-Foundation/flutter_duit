.PHONY: deps lint format test cov

deps:
	fvm flutter pub get

lint:
	fvm flutter analyze .

format:
	fvm dart format .

test:
	cd packages/flutter_duit && fvm flutter test -j=10

cov:
	cd packages/flutter_duit && fvm flutter test -j=10 --coverage \
		&& genhtml coverage/lcov.info --output=coverage/html \
		&& open coverage/html/index.html
