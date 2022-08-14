# !/bin/bash

flutter pub get
flutter pub run build_runner build

for d in $(ls packages)
	do cd packages/$d
	flutter pub get
	flutter pub run build_runner build
	cd -
done

