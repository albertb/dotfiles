#!/bin/sh

for file in $(ls -A); do
  if [ ${file} != ${BASH_SOURCE} ]; then
    ln -vsf ${PWD}/${file} ${HOME}/test/${file}
  fi
done
