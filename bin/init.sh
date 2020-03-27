#!/usr/bin/env bash
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
set -e
echo "[i] Ask for sudo password"
sudo -v

# install Command Line Tools
if [[ ! -x /usr/bin/gcc ]]; then
  echo "[i] Install macOS Command Line Tools"
  xcode-select --install
fi

# install homwbrew
if [[ ! -x /usr/local/bin/brew ]]; then
  echo "[i] Install Homebrew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# install ansible
if [[ ! -x /usr/local/bin/ansible ]]; then
  echo "[i] Install Ansible"
  brew install ansible
fi

# set macos defaults
echo "[i] Set some specific macOS settings"
set +e
bash ${BASEDIR}/osx-defaults/set-defaults.sh
set -e

if [ -f "$HOME/.zshrc" ] && [ ! -h "$HOME/.zshrc" ]
then
  echo "[i] Move current ~/.zshrcto ~/zshrc.backup"
  mv "$HOME/.zshrc" "$HOME/zshrc_backup"
fi

if [ -f "$HOME/.zshrc" ] && [ ! -h "$HOME/.zshrc" ]
then
  echo "[i] Move current ~/.zshrc to ~/zshrc_backup"
  mv "$HOME/.zshrc" "$HOME/zshrc_backup"
fi

# Run main playbook
echo "[i] Run Playbook"
ansible-playbook ../ansible/dotfiles.yml --ask-become-pass

echo "[i] Done."
