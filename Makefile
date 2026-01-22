.PHONY: gen gen-l10n gen-l10n-keys gen-assets gen-assets-clean clean help

## Generate all (localization + assets)
gen: gen-l10n gen-l10n-keys gen-assets

## Generate localization loader
gen-l10n:
	dart run easy_localization:generate -S "assets/translations" -O "lib/core/generated/localization"

## Generate localization keys
gen-l10n-keys:
	dart run easy_localization:generate -S "assets/translations" -O "lib/core/generated/localization" -f keys -o "locale_keys.g.dart"

## Generate assets (flutter_gen)
gen-assets:
	dart run build_runner build

## Generate assets with delete conflicting outputs
gen-assets-clean:
	dart run build_runner build --delete-conflicting-outputs

## Clean build
clean:
	flutter clean
	flutter pub get

## Help
help:
	@echo "Available commands:"
	@echo "  make gen              - Generate all (localization + assets)"
	@echo "  make gen-l10n         - Generate localization loader"
	@echo "  make gen-l10n-keys    - Generate localization keys"
	@echo "  make gen-assets       - Generate assets (flutter_gen)"
	@echo "  make gen-assets-clean - Generate assets with --delete-conflicting-outputs"
	@echo "  make clean            - Clean and get dependencies"
