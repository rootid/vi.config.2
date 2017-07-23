#!/bin/sh

#java -jar google-java-format-1.3-all-deps.jar -aosp -i ${1}

#java -jar google-java-format-1.3-all-deps.jar -length --fix-imports-only -i ${1}
echo "replacing ${1}"
java -jar $VI_CONF/vi.bin/google-java-format-1.3-all-deps.jar --fix-imports-only -i ${1}
#echo "processed ${1}"

#clang-format -i ${1}

#java -jar google-java-format-1.3-all-deps.jar -offset 0 -length 100 -i ${1}
#--fix-imports-only
#--length
