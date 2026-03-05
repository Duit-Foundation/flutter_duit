.PHONY: deps lint format test cov publish-dry publish

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

publish-dry:
	cd packages/flutter_duit && fvm flutter pub publish --dry-run

publish:
	cd packages/flutter_duit && fvm flutter pub publish
