#!/usr/bin/env fish

function install_patched_fonts
  echo "--- Installing patched fonts ---"
  cd $HOME
  git clone https://github.com/powerline/fonts.git --depth=1
  cd fonts
  ./install.sh
  cd ..
  rm -rf fonts
end

function install_config_files
  echo "--- Installing fish config files ---"
  cd $HOME/.config/fish
  ln -s $HOME/dotfiles/fish/*.fish .
end

function install_fisherman
  echo "--- Installing fisherman ---"
  curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

  echo "--- Installing plugins ---"
  fisher add decors/fish-colored-man fisherman/z oh-my-fish/theme-agnoster
end

install_patched_fonts
install_config_files
install_fisherman
