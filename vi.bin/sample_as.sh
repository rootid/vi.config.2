
#!/bin/bash

filename=$1

if [[ -n "$filename" ]]; then
  astyle \
  --style=java \
  --indent=spaces=4 \
  --max-code-length=120 \
  --break-after-logical \
  --mode=java \
  --lineend=linux \
$filename
else
    echo "argument error"
fi

rm -rf $filename.orig
