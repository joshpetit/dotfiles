#!/bin/sh
while [ $# -gt 1 ]; do
  eval "target=\${$#}"
  original="$1"
  if [ -d "$target" ]; then
    target="$target/${original##*/}"
  fi
  mv -- "$original" "$target"
  case "$original" in
    */*)
      case "$target" in
        /*) :;;
        *) target="$(cd -- "$(dirname -- "$target")" && pwd)/${target##*/}"
      esac
  esac
  ln -s -- "$target" "$original"
  shift
done
