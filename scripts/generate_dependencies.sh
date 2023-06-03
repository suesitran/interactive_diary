# !/bin/bash
# NOTE: Please install fluttergen to successfully run this script
# https://pub.dev/packages/flutter_gen

flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter --no-color pub run intl_utils:generate
fluttergen -c pubspec.yaml

for d in $(ls packages)
	do cd packages/$d
	flutter pub get
	flutter pub run build_runner build --delete-conflicting-outputs
	cd -
done

