#!/usr/bin/env zsh

export PATH="$PATH:/usr/local/bin:/usr/bin:/bin" &&
# for i in "$(seq 1 10)"; do
#   echo "${i}"
# done | read -d '' one2ten
# echo $one2ten | gum choose --no-limit
# for i ($one2ten) (echo "Hello, ${i}")
# echo $one2ten | xargs -I _ echo "Hello, _"
echo 'abc\ndef\nghi' | read -d '' alphabet
echo $alphabet | gum choose --no-limit
# for i ($alphabet) (echo "Hello, ${i}")
