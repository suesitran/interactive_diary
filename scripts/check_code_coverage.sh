#!/bin/bash
set -e

rm -rf coverage
mkdir coverage
touch coverage/lcov.base.info

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

 remove=('lib/main.dart' \
            'lib/*/*.g.dart' \
            'lib/*/*.part.dart' \
            '**/generated/**' \
            '**/gen/**' \
            '**/*.mocks.dart' \
            'lib/models/*/*.dart' \
            'lib/models/*.dart' \
            '**/test/**' \
            'lib/route/**' \
            'lib/debug/**' \
            'lib/service_locator/**'
            'test/**' )

removeFiles=""
files=$(git diff --name-only dev)
arr=($files)

# prepare files not to test
for p in "${remove[@]}"; do
  removeFiles+=" $p"
  arr=( "${arr[@]/$p}" )
done

nonTestFiles=""
testFiles=""
for file in ${arr[@]}; do
  if [[ "$file" == *".dart"* ]]; then
    if [[ "$file" == *"test"* ]]; then
      echo "${GREEN} testing --- written tests for $file  ${NC}"
      temp=${file/"_test"/""}

      if [[ $file == *"packages"* ]]; then
        echo $file
        tail="${file#*/*/}"
        head="${file%/$tail}"
        testFiles+=" $(find $head -name $(basename "$temp"))"
        cd $head
        flutter test --coverage "$tail"
        var1=lib/
        var2=$head/lib/
        LOCAL_COVERAGE_FILE_PATH="coverage/lcov.info"
        sed -i '' -e "s@${var1}@${var2}@" "${LOCAL_COVERAGE_FILE_PATH}"
        cat coverage/lcov.info >>../../coverage/lcov.base.info

        rm -rf coverage/lcov.info
        cd ..
        cd ..

      else
        module="lib"
        testFiles+=" $(find $module -name $(basename $temp))"
        flutter test --coverage "$file"
        cat coverage/lcov.info >>coverage/lcov.base.info
      fi
    else
      nonTestFiles+=" $file"
    fi
  fi
done

for file in ${arr[@]}; do
#  echo "$file"
  if [[ "$file" == *".dart"* ]]; then

    file=${file/".dart"/""}
    if [[ "$file" != *"test"* && "$testFiles" != *"$(basename "$file")"* ]]; then
      if [[ $file == *"packages"* ]]; then

        tail="${file#*/*/}"
        head="${file%/$tail}"
        testFile="$(find $head -name "$(basename $file)_test[.]dart")"
        if [[ $testFile == "" ]]; then
        cd $head
          creatFile="test/$(basename $file)_test.dart"

          touch $creatFile

           echo "\n${GREEN} Temporary file created to find coverage ${BLUE}$creatFile${NC}"

            tee "$creatFile" <<< "import 'package:flutter_test/flutter_test.dart'; void main() {test('Dummy', () {});}"
            echo "\n${GREEN} testing --- changed in $file detected.${NC}"
            flutter test --coverage $creatFile
             rm -rf $creatFile
                        echo "\n${RED} Deleted ${BLUE}$creatFile${NC}"
             var1=lib/
                    var2=$head/lib/
                    LOCAL_COVERAGE_FILE_PATH="coverage/lcov.info"
                    sed -i '' -e "s@${var1}@${var2}@" "${LOCAL_COVERAGE_FILE_PATH}"
           cat coverage/lcov.info >>../../coverage/lcov.base.info
                    rm -rf coverage/lcov.info

            cd ..
            cd ..

          continue
        fi
        echo "\n${GREEN} testing --- changed in $file detected"

        cd $head
        flutter test --coverage $(find test -name "$(basename "$file")_test[.]dart")
        var1=lib/
        var2=$head/lib/
        LOCAL_COVERAGE_FILE_PATH="coverage/lcov.info"
        sed -i '' -e "s@${var1}@${var2}@" "${LOCAL_COVERAGE_FILE_PATH}"
        cat coverage/lcov.info >>../../coverage/lcov.base.info
        rm -rf coverage/lcov.info
        cd ..
        cd ..

      else

        dir="test"
        if [[ $(find $dir -name "$(basename $file)_test[.]dart") == "" ]]; then

          creatFile="test/$(basename $file)_test.dart"
          touch $creatFile
          echo "\n${GREEN} Temporary file created to find coverage ${BLUE}$creatFile${NC}"

           tee "$creatFile" <<< "import 'package:flutter_test/flutter_test.dart'; void main() {test('', () {});}"
            echo "${GREEN} testing --- changed in $file detected.${NC}"
            flutter test --coverage "$creatFile"
            rm -rf "$creatFile"
            echo "\n${RED} Deleted ${BLUE}$creatFile${NC}"
            cat coverage/lcov.info >>coverage/lcov.base.info
        rm -rf coverage/lcov.info
          continue
        fi
        echo "${GREEN} testing --- changed in $file detected.${NC}"
        flutter test --coverage $(find test -name "$(basename "$file")_test[.]dart")
        cat coverage/lcov.info >>coverage/lcov.base.info
        rm -rf coverage/lcov.info
      fi

    fi
  fi
done

echo "\n Tested : $testFiles \n $nonTestFiles \n"

lcov --remove coverage/lcov.base.info $removeFiles -o coverage/lcov.base.info

sh lcov -e coverage/lcov.base.info $nonTestFiles $testFiles -o coverage/lcov.base.info

echo "generating html..."
genhtml coverage/lcov.base.info -o coverage/html
open coverage/html/index.html
