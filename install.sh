#!/bin/sh

rm -rvf ${HOME}/.xmonad &&
rm -rvf ${HOME}/.vim &&
for file in $(ls -A); do
  [ ${file} == "install.sh" ] ||
  [ ${file} == ".git" ] ||
  [ ${file} == "DefaultKeyBinding.dict" ] ||
  (rm ${HOME}/${file}; ln -vsF ${PWD}/${file} ${HOME}/${file})
done

if [[ $(uname) == "Darwin" ]]; then
  mkdir ${HOME}/Library/KeyBindings &&
  ln -vsF ${PWD}/DefaultKeyBinding.dict ${HOME}/Library/KeyBindings
fi
