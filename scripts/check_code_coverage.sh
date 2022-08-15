# !/bin/sh

root=$(pwd)

flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter test --coverage
cat coverage/lcov.info > lcov.base.info

for d in $(ls packages)
	do cd packages/$d
	flutter pub get
	flutter pub run build_runner build --delete-conflicting-outputs
	flutter test --coverage

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
