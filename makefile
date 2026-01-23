builds:
	dart run build_runner build --delete-conflicting-outputs

launcher_icons:
	dart run flutter_launcher_icons

languages:
	flutter pub run intl_utils:generate

clean:
	flutter clean && flutter pub get

apk_build:
	flutter build apk

apk_install:
	flutter build apk && flutter install

split_apk_build:
	flutter build apk --split-per-abi

change_package:
	flutter pub run change_app_package_name:main $(name)

run_dev:
	flutter run  --dart-define-from-file=config/config.dev.json

run_prod:
	flutter run --dart-define-from-file=config/config.prod.json

build_dev:
	flutter build apk --split-per-abi --dart-define-from-file=config/config.dev.json
build_apk_dev:
	flutter build apk --dart-define-from-file=config/config.dev.json && flutter install

build_prod:
	flutter build apk --dart-define-from-file=config/config.prod.json

run_release:
	flutter run --release --dart-define-from-file=config/config.dev.json

build_aab:
	flutter build appbundle --release --dart-define-from-file=config/config.prod.json
