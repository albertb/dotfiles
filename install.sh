#!/bin/sh

if [[ $(uname) == "Darwin" ]]; then
  mkdir ${HOME}/Library/KeyBindings &&
  ln -vsF ${PWD}/DefaultKeyBinding.dict ${HOME}/Library/KeyBindings
fi
