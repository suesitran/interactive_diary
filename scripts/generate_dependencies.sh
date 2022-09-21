# !/bin/bash

flutter pub get
flutter pub run build_runner build
flutter --no-color pub run intl_utils:generate

for d in $(ls packages)
	do cd packages/$d
	flutter pub get
	flutter pub run build_runner build
	cd -
done

