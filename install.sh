#!/bin/sh

for file in $(ls -A); do
  [ ${file} == "install.sh" ] ||
  [ ${file} == ".git" ] ||
  ln -vsf ${PWD}/${file} ${HOME}/test/${file}
done
