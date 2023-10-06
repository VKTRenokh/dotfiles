
#!/usr/bin/env bash

if [ $((1 + RANDOM % 10)) -ge 5 ]; then
  pfetch
else
  bunnyfetch
fi
