# !/bin/sh

root=$(pwd)

rm -r coverage/

flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter test --coverage
lcov --remove coverage/lcov.info -o coverage/lcov.info \
	'lib/generated/**' \
	'lib/firebase_options.dart' \
	'lib/main.dart' \
	'lib/constants.dart' \
	'lib/route.dart'

cat coverage/lcov.info > coverage/lcov.base.info

for d in $(ls packages)
	do cd packages/$d
	flutter pub get
	build_runner=$(grep "build_runner" pubspec.yaml)

	if [[ "${build_runner}" != "" ]]; then
	  flutter pub run build_runner build --delete-conflicting-outputs
	fi
	flutter test --coverage

  lcov --remove coverage/lcov.info -o coverage/lcov.info \
	'lib/generated/**' \
	'lib/**/*.g.dart' \
	'lib/**/data/**' \
	'lib/**/hive/*_adapters.dart'

	dir=$(pwd)

	var1=lib
	var2=${dir#"$root/"}\/lib

	sed -i'' -e "s@${var1}@${var2}@" "coverage/lcov.info"
	
	cat coverage/lcov.info >> $root/coverage/lcov.base.info
	rm -r coverage/
	cd -
done
cd $root

echo 'Generate html'
genhtml coverage/lcov.base.info -o coverage/html
open coverage/html/index.html
