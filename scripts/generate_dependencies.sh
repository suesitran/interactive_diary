# !/bin/bash
# NOTE: Please install fluttergen to successfully run this script
# https://pub.dev/packages/flutter_gen

GREEN='\033[0;32m'
NC='\033[0m'

flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart run intl_utils:generate
#fluttergen -c pubspec.yaml

for d in $(ls packages); do
  echo "${GREEN} Start pub get in $d  ${NC}"
  cd packages/$d
	flutter pub get
	grep=$(grep "build_runner" pubspec.yaml)

	if [[ "$grep" != "" ]]; then
	  echo "${GREEN} Run build_runner in $d  ${NC}"
		dart run build_runner build --delete-conflicting-outputs
	else
	  echo "${GREEN} $d does not have build_runner  ${NC}"
	fi
	cd -
done

