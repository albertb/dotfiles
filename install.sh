#!/bin/sh

rm -vf ${HOME}/.xmonad &&
rm -vf ${HOME}/.vim &&
for file in $(ls -A); do
  [ ${file} == "install.sh" ] ||
  [ ${file} == ".git" ] ||
  ln -vsF ${PWD}/${file} ${HOME}/${file}
done
