#!/usr/bin/env bash

echo "⚙️ Starting ..."
sleep 1

read -p "👤 Please, enter your name: " AUTHOR
read -p "📧 Please, enter your email: " EMAIL

inquire() {
  while true; do
    read -p "$1 " yn
    case $yn in
    [Yy]*) return 0 ;;
    [Nn]*) return 1 ;;
    *) echo "Please answer y/Y or n/N" ;;
    esac
  done
}

if inquire "🔑 Do you want to generate SSH keys (y/n)?"; then
  echo "🔑 Generating SSH keys..."
  ssh-keygen -t rsa -b 4096 -N '' -C "${EMAIL}" -f ~/.ssh/id_rsa
else
  echo "⏩ Skipping generation of SSH keys..."
fi

if inquire "⚙️ Do you want to install Xcode command line tools (y/n)?"; then
  echo "⚙️ Installing Xcode command line tools..."
  xcode-select --install
else
  echo "⏩ Skipping installation of Xcode command line tools..."
fi

if inquire "🍺 Do you want to install Homebrew (y/n)?"; then
  echo "🍺 Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update

  echo "🍺 Installing homebrew cask"
  brew install caskroom/cask/brew-cask

  echo "🍺 Homebrew tap caskroom/fonts..."
  brew tap caskroom/fonts

  echo "🍺 Homebrew tap caskroom/versions..."
  brew tap caskroom/versions

  echo "🍺 Homebrew tap homebrew/cask-versions..."
  brew tap homebrew/cask-versions

  echo "🍺 Homebrew tap clojure/tools..."
  brew tap clojure/tools

  brew --version
else
  echo "⏩ Skipping installation of Homebrew..."
fi

echo "🦊 Installing Mozilla Firefox..."
brew install --cask firefox

echo "🦁 Installing Mozilla Brave Browser..."
brew install --cask brave-browser

echo "💻 Installing iTerm2..."
brew install --cask iterm2

echo "💻 Installing Open In Terminal"
brew install --cask openinterminal

echo "📚 Installing Dash..."
brew install --cask dash

echo "☁️ Installing Dropbox..."
brew install --cask dropbox

echo "⚙️ Installing Slack..."
brew install --cask slack

echo "🌳 Installing Sourcetree"
brew install --cask sourcetree

echo "⚙️ Installing Bartender"
brew install --cask bartender

echo "⚙️ Installing Bartender"
brew install --cask appcleaner

echo "⚙️ Installing Visual Studio Code..."
brew install --cask visual-studio-code

echo "⚙️ Installing Telegram..."
brew install --cask telegram-desktop

echo "⚙️ Installing Zoom..."
brew install --cask zoom

echo "⚙️ Installing Discord..."
brew install --cask discord

echo "⚙️ Installing Spotify..."
brew install --cask spotify

echo "⚙️ Installing VLC..."
brew install --cask vlc

echo "🦆 Installing Cyberduck..."
brew install --cask cyberduck

echo "Installing DB Browser for SQLite"
brew install --cask db-browser-for-sqlite

echo "📦 Installing VirtualBox..."
brew install --cask virtualbox

if inquire "Do you want to install Ganache (y/n)?"; then
  echo "⚙️ Installing Ganache..."
  brew install --cask ganache
else
  echo "⏩ Skipping installation of Ganache..."
fi

if inquire "⚙️ Do you want to install and configure Git (y/n)?"; then
  echo "⚙️ Installing Git..."
  brew install git
  git --version

  echo "⚙️ Installing Git extensions..."
  brew install git-flow git-extras git-lfs

  echo "⚙️ Installing GitHub CLI..."
  brew install hub

  if inquire "Do you want to configure Git (y/n)?"; then
    echo "⚙️ Configuring Git..."
    git config --global user.name "${AUTHOR}"
    git config --global user.email "${EMAIL}"
  else
    echo "⏩ Skipping configuration of git..."
  fi
else
  echo "⏩ Skipping installation of git..."
fi

if inquire "❤️ Do you want to install the GNU software collection? (y/n)?"; then
  # See: https://www.gnu.org/software/coreutils/
  if inquire "🔴 Do you want to install GNU coreutils (y/n)?"; then
    echo "🔴 Installing GNU coreutils..."
    brew install --force-bottle coreutils
  else
    echo "⏩ Skipping installation of GNU coreutils..."
  fi

  # See: https://www.gnu.org/software/diffutils/
  if inquire "🟠 Do you want to install GNU diffutils (y/n)?"; then
    echo "🟠 Installing GNU diffutils..."
    brew install --force-bottle diffutils
  else
    echo "⏩ Skipping installation of GNU diffutils..."
  fi

  # See: https://savannah.gnu.org/projects/which/
  if inquire "🟡 Do you want to install GNU which (y/n)?"; then
    echo "🟡 Installing GNU which..."
    brew install gnu-which --with-default-names
  else
    echo "⏩ Skipping installation of GNU which..."
  fi

  # See: https://www.gnu.org/software/sed/
  if inquire "🟢 Do you want to install GNU sed (y/n)?"; then
    echo "🟢 Installing GNU sed..."
    brew install gnu-sed --with-default-names
  else
    echo "⏩ Skipping installation of GNU sed..."
  fi

  # See: https://www.gnu.org/software/findutils/
  if inquire "🔍 Do you want to install GNU findutils (y/n)?"; then
    echo "🔍 Installing GNU findutils (find, locate, updatedb, and xargs)..."
    brew install --force-bottle findutils --with-default-names
  else
    echo "⏩ Skipping installation of findutils..."
  fi

  # See: https://www.gnu.org/software/indent/
  if inquire "🟣 Do you want to install GNU Indent (y/n)?"; then
    echo "🟣 Installing GNU Indent..."
    brew install gnu-indent
  else
    echo "⏩ Skipping installation of GNU indent..."
  fi

  # See: https://www.gnu.org/software/grep/
  if inquire "🔍 Do you want to install GNU grep (y/n)?"; then
    echo "🔍 Installing GNU grep..."
    brew install grep --with-default-names
  else
    echo "⏩ Skipping installation of GNU grep..."
  fi
fi


if inquire "🗜 Do you want to install compression/decompression tools (y/n)?"; then
  echo "🗜 Installing The Unarchiver..."
  brew install --cask the-unarchiver

  echo "🗜 Install GNU tar..."
  brew install gnu-tar --with-default-names

  echo "🗜 Installing unrar, xz and gzip..."
  brew install unrar xz gzip
else
  echo "⏩ Skipping installation of compression/decompression tools..."
fi

if inquire "💡 Do you want to install various programming languages (y/n)?"; then
  if inquire "🐍 Do you want to install Python 3 (y/n)?"; then
    echo "🐍 Installing Python..."
    brew install python@3.9 ipython pyenv
    python --version; pyenv --version;
  fi

  if inquire "🦀 Do you want to install Rust (y/n)?"; then
    echo "🦀 Installing Rust..."
    curl https://sh.rustup.rs -sSf | sh
    rustup update; rustc --version;
  fi

  if inquire "⚙️ Do you want to install Erlang (y/n)?"; then
    echo "⚙️ Installing Erlang..."
    brew install erlang rebar3
  fi

  if inquire "🧪 Do you want to install Elixir (y/n)?"; then
    echo "🧪 Installing Elixir..."
    brew install elixir
    iex --version
  fi

  if inquire "☕️️ Do you want to install Java (y/n)?"; then
    echo "☕️️ Installing Java..."
    brew install --cask java
    java --version
  fi

  if inquire "⚙️ Do you want to install Clojure (y/n)?"; then
    echo "⚙️ Installing Clojure..."
    brew install clojure/tools/clojure leiningen
  fi
else
  echo "⏩ Skipping installation of programming languages..."
fi


if inquire "Do you want to install Binance (y/n)?"; then
  echo "⚙️ Installing Binance..."
  brew install --cask binance
fi

if inquire "Do you want to install Ledger Live (y/n)?"; then
  echo "⚙️ Installing Ledger Live..."
  brew install --cask ledger-live
fi

if inquire "Do you want to install fonts (y/n)?"; then
  echo "⚙️ Installing fonts..."
  fonts=(
    font-hasklig
    font-fira-code
    font-hack-nerd-font
    font-anonymous-pro
    font-inconsolidata
  )
  brew install --cask "${fonts[@]}"
fi

if inquire "🛡 Do you want to install privacy and security software (y/n)?"; then
  if inquire "Do you want to install Tor Browser (y/n)?"; then
    brew install --cask tor-browser
  fi
  if inquire "🔒 Do you want to install GPG Suite (y/n)?"; then
    echo "🔒 Installing GPG Suite..."
    brew install --cask gpg-suite
  fi
  if inquire "🔑 Do you want to install OpenSSH (y/n)?"; then
    brew install openssh
  fi
  if inquire "🔑 Do you want to install OpenSSL (y/n)?"; then
    brew install openssl
  fi
  if inquire "⚙️ Do you want to install 1Password (y/n)?"; then
    echo "⚙️ Installing 1Password..."
    brew install --cask 1password
  fi
  if inquire "🟥 Do you want to install Authy (y/n)?"; then
    echo "🟥 Installing Authy..."
    brew install --cask authy
  fi
  if inquire "🐻 Do you want to install TunnelBear (y/n)?"; then
    echo "🐻 Installing TunnelBear..."
    brew install --cask tunnelbear
  fi
  if inquire "☁️ Do you want to install CloudFlare Warp (y/n)?"; then
    echo "☁️ Installing CloudFlare Warp..."
    brew install --cask cloudflare-warp
  fi
else
  echo "⏩ Skipping installation of privacy and security software..."
fi

if inquire "🛠 Do you want to install JetBrain's IDEs (y/n)?"; then
  echo "⚙️ Installing JetBrains Toolbox..."
  brew install --cask jetbrains-toolbox

  if inquire "Do you want to install PyCharm (y/n)?"; then
    echo "⚙️ Installing PyCharm Professional..."
    brew install --cask pycharm
  fi

  if inquire "Do you want to install WebStorm (y/n)?"; then
    echo "⚙️ Installing WebStorm..."
    brew install --cask webstorm
  fi

  if inquire "Do you want to install DataGrip (y/n)?"; then
    echo "⚙️ Installing DataGrip..."
    brew install --cask datagrip
  fi

  if inquire "Do you want to IntelliJ IDEA Ultimate (y/n)?"; then
    echo "⚙️ Installing IntelliJ IDEA Ultimate..."
    brew install --cask intellij-idea
  fi
fi

if inquire "🔬 Do you want to install network/traffic analysis tools (y/n)?"; then
  utils=(
    mtr
    tmux
    ngrok
    telnet
    tcpdump
    wireshark
    prettyping
  )
  brew install "${utils[@]}"
fi

if inquire "🛠 Do you want to install Node and TypeScript (y/n)?"; then
  brew install nvm node typescript deno
fi

echo "🛠 Installing misc developer CLI-tools..."
dev_utils=(
  jq
  bat
  tokei
  httpie
  neovim
  ffmpeg
  libjpeg
  gettext
  hadolint
  automake
  readline
  hyperfine
  shellcheck
  screenfetch
)
brew install "${dev_utils[@]}"

echo "⚙️ Installing other libraries and commandline utils..."
brew install fzf wget tree trash rename readline

if inquire "🐠 Do you want to install fish (y/n)?"; then
  echo "🐠 Installing fish..."
  brew install fish

  echo "🐠 Setting up fish as default..."
  chsh -s /usr/local/bin/fish

  echo "🐠 Installing oh-my-fish..."
  curl -L https://get.oh-my.fish | fish

  echo "🐠 Changing theme..."
  omf theme idan
else
  echo "⏩ Skipping installation of fish..."
fi

brew cleanup

echo "💻 Changing macOS's settings..."

# Change screenshots location
mkdir /Users/likid_geimfari/Pictures/Screenshots
defaults write com.apple.screencapture location /Users/likid_geimfari/Pictures/Screenshots

# Disable fucking shit I fucking hate.
defaults write com.apple.dashboard mcx-disabled -boolean YES

# This line deactivates rubber scrolling:
# http://osxdaily.com/2012/05/10/disable-elastic-rubber-band-scrolling-in-mac-os-x/
defaults write -g NSScrollViewRubberbanding -int 0

# Disable startup noise:
sudo nvram SystemAudioVolume=%01

# Scrollbars visible when scrolling:
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

# Maximize windows on double clicking them:
defaults write -g AppleActionOnDoubleClick 'Maximize'

defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Keep folders on top when sorting by name:
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Show Finder path bar:
defaults write com.apple.finder ShowPathbar -bool true

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Improve Safari security
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles -bool false

# Disable autocorrect:
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable auto-capitalization:
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Notification dismiss timeout:
defaults write com.apple.notificationcenterui bannerTime -int 4

killall Finder
killall Dock

echo '✨ Done!'
