#!/bin/bash
# Some Debian configuration for myself.
# By Arvin.X.

hostname=''

function prompt(){
  echo -ne "\033[01;32m${1}\033[0m"
}

function config_apt(){
  echo 'Configure apt...'
  echo '# kali rolling' >> /etc/apt/sources.list
  echo 'deb http://http.kali.org/kali kali-rolling main contrib non-free' >> /etc/apt/sources.list
  apt-get update
  echo 'Configure apt...Done.'
}

function config_bash(){
  echo 'Configure bash...'
  cp .bashrc ~/.bashrc
  read -p 'Input hostname: ' hostname
  echo '' >> ~/.bashrc 
  echo '# PS1' >> ~/.bashrc
  echo "export PS1=\"\[\033[01;31m\]\u@${hostname}\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$ \"" >> ~/.bashrc
  echo 'Configure bash...Done.'
}

function config_hostname(){
  echo -n 'Configure hostname...'
  echo "Arvin_X-${hostname}" > /etc/hostname
  echo 'Done.'
}

function config_vim(){
  echo -n 'Configure vim...'
  cp .vimrc ~/.vimrc
  echo 'Done.'
}

function config_tmux(){
  echo 'Configure tmux...'
  apt-get install tmux -y
  cp .tmux.conf ~/.tmux.conf
  echo 'Configure tmux...Done.'
}

config_apt
config_bash
config_hostname
config_vim
config_tmux

