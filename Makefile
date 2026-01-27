.PHONY: gen gen-l10n gen-l10n-keys gen-assets gen-assets-clean clean fix-svg help

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

## Convert SVG files in assets/images and assets/icons to UTF-8
fix-svg:
	@echo "Converting SVG files to UTF-8..."
	@for file in assets/images/*.svg assets/icons/*.svg; do \
		if [ -f "$$file" ]; then \
			encoding=$$(file -b --mime-encoding "$$file"); \
			if [ "$$encoding" != "utf-8" ] && [ "$$encoding" != "us-ascii" ]; then \
				echo "Converting $$file from $$encoding to UTF-8"; \
				iconv -f UTF-16LE -t UTF-8 "$$file" > "$$file.tmp" && mv "$$file.tmp" "$$file"; \
			fi; \
		fi; \
	done
	@echo "Done!"

## Help
help:
	@echo "Available commands:"
	@echo "  make gen              - Generate all (localization + assets)"
	@echo "  make gen-l10n         - Generate localization loader"
	@echo "  make gen-l10n-keys    - Generate localization keys"
	@echo "  make gen-assets       - Generate assets (flutter_gen)"
	@echo "  make gen-assets-clean - Generate assets with --delete-conflicting-outputs"
	@echo "  make clean            - Clean and get dependencies"
	@echo "  make fix-svg          - Convert SVG files in assets/images and assets/icons to UTF-8"
