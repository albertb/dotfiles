#!/bin/sh

rm -rvf ${HOME}/.xmonad &&
rm -rvf ${HOME}/.vim &&
for file in $(ls -A); do
  [ ${file} == "install.sh" ] ||
  [ ${file} == ".git" ] ||
  (rm ${HOME}/${file}; ln -vsF ${PWD}/${file} ${HOME}/${file})
done
