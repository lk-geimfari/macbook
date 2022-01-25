#!/usr/bin/env bash

DEFAULT_HOSTNAME="Macbook"

success() {
  echo -e "\e[1;32m$1\e[0m"
}

info() {
  echo -e "\e[1;34m$1\e[0m"
}

warning() {
  echo -e "\e[1;33m$1\e[0m"
}

error() {
  echo -e "\e[1;31m$1\e[0m"
}

read -e -p "$(success '💻 Enter host name: ')" -i "${DEFAULT_HOSTNAME}" HOSTNAME
read -e -p "$(success '💻 Enter computer name: ')" -i "${DEFAULT_HOSTNAME}" COMPUTER_NAME
read -e -p "$(success '💻 Enter local host name: ')" -i "${DEFAULT_HOSTNAME}" LOCAL_HOSTNAME

read -e -p "$(success '📧 Enter your email: ')" USER_EMAIL
read -e -p "$(success '👤 Enter your nickname: ')" USERNAME
read -e -p "$(success '👤 Enter your full name: ')" FULL_NAME

ask() {
  while true; do
    read -p "$(success "$1 (y/n)?") " yn
    case $yn in
    [Yy]*) return 0 ;;
    [Nn]*) return 1 ;;
    *) error "Please answer y/Y or n/N" ;;
    esac
  done
}

if ask "Have you just turned on your new Macbook (literally, just right now)"; then
  warning "You have to use your Macbook for a while to make it produce enough entropy for generating strong random numbers"
else
  if ask "🔑 Do you want to generate SSH keys"; then
    read -e -p "Please, specify the type of key (RSA or ED25519): " -i "RSA" SSH_KEY_TYPE

    case $SSH_KEY_TYPE in
    1 | rsa | RSA)
      success "🔑 Generating SSH keys (RSA with 4096 bits and 150 rounds of KDF)..."
      ssh-keygen -t rsa -b 4096 -o -a 150 -C "${USER_EMAIL}" -f ~/.ssh/id_rsa
      ;;
    2 | ed | ed25519 | ED25519)
      success "🔑 Generating SSH keys (Ed25519 with 150 rounds of KDF)..."
      ssh-keygen -t ed25519 -o -a 150 -C "${USER_EMAIL}" -f ~/.ssh/id_ed25519
      ;;
    *)
      warning "Unknown key type. Skipping generation of keys..."
      ;;
    esac
  else
    warning "Skipping generation of SSH keys..."
  fi
fi

if ! command -v xcode-select &>/dev/null; then
  success "⚙️ Installing Xcode command line tools..."
  xcode-select --install
  xcode-select --version
fi

if ! command -v brew &>/dev/null; then
  success "🍺 Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update

  success "🍺 Homebrew: tap caskroom/versions..."
  brew tap caskroom/versions

  success "🍺 Homebrew: tap homebrew/cask-versions..."
  brew tap homebrew/cask-versions

  if ask "🍺 Do you want to install Cakebrew"; then
    brew install --cask cakebrew
  fi
  brew --version
fi

if ask "Do you want to install command-line interface for App Store"; then
  success "Installing mas..."
  brew install mas

  if ask "Do you want to install Xcode"; then
    success "⚙️ Installing Xcode..."
    mas install 497799835

    if ask "How about Swift Playground"; then
      mas install 1496833156
    fi
  fi

  if ask "Do you want to install Microsoft To Do"; then
    success "⚙️ Installing Microsoft To Do..."
    mas install 1274495053
  fi

  if ask "Do you want to install Magnet"; then
    success "⚙️ Installing Magnet..."
    mas install 441258766
  fi
fi

if ask "Does your Macbook has notch?"; then
  if ask "Do you want to install TopNotch?"; then
    success "⚙️ Installing TopNotch..."
    brew install --cask topnotch
  fi
  if ask "Do you want to install Bartender?"; then
    success "⚙️ Installing Bartender..."
    brew install --cask bartender
  fi
fi

if ask "Do you want to install web browsers"; then
  if ask "Do you want to install Mozilla Firefox"; then
    success "🦊 Installing Mozilla Firefox..."
    brew install --cask firefox
  fi

  if ask "Do you want to install Brave Browser"; then
    success "🦁 Installing Brave Browser..."
    brew install --cask brave-browser
  fi
else
  warning "Skipping installation of browsers..."
fi

if ask "Do you want to install communication apps"; then
  if ask "Do you want to install Slack"; then
    success "⚙️ Installing Slack..."
    brew install --cask slack
  fi
  if ask "Do you want to install Telegram"; then
    success "⚙️ Installing Telegram..."
    brew install --cask telegram
  fi
  if ask "Do you want to install Zoom"; then
    success "⚙️ Installing Zoom..."
    brew install --cask zoom
  fi
  if ask "Do you want to install Discord"; then
    success "⚙️ Installing Discord..."
    brew install --cask discord
  fi
fi

if ask "Do you want to install iTerm2"; then
  success "💻 Installing iTerm2..."
  brew install --cask iterm2

  success "💻 Installing Open In Terminal"
  brew install --cask openinterminal
fi

if ask "Do you want to install AppCleaner"; then
  success "⚙️ Installing AppCleaner..."
  brew install --cask appcleaner
fi

if ask "Do you want to install VLC"; then
  success "⚙️ Installing VLC..."
  brew install --cask vlc
fi

if ask "Do you want to install Spotify"; then
  success "⚙️ Installing Spotify..."
  brew install --cask spotify
fi

if ask "Do you want to install cloud utils"; then
  if ask "Do you want to install Dropbox"; then
    success "☁️ Installing Dropbox..."
    brew install --cask dropbox
  fi
  if ask "Do you want to install Cyberduck"; then
    success "🦆 Installing Cyberduck..."
    brew install --cask cyberduck
  fi
fi

if ask "Do you want to install VirtualBox"; then
  success "📦 Installing VirtualBox..."
  brew install --cask virtualbox
fi

if ask "Do you want to install Dash"; then
  success "📚 Installing Dash..."
  brew install --cask dash
fi

if ask "Do you want to install Visual Studio Code"; then
  success "⚙️ Installing Visual Studio Code..."
  brew install --cask visual-studio-code

  if command -v code &>/dev/null; then
    if ask "Do you want to install extensions for your VS Code"; then
      if ask "[VS Code] Do you want to install extensions for programming languages"; then
        if ask "[VS Code] Do you want to install Python"; then
          code --install-extension ms-python.python
          code --install-extension dongli.python-preview
          code --install-extension ms-python.vscode-pylance
          code --install-extension batisteo.vscode-django
        fi

        if ask "[VS Code] Do you want to install Clojure"; then
          code --install-extension vscjava.vscode-java-dependency
          code --install-extension avli.clojure
        fi
      fi
    fi
  fi

fi

if ask "Do you want to install DB management tools"; then
  if ask "Do you want to install DB Browser for SQLite"; then
    success "⚙️ Installing DB Browser for SQLite"
    brew install --cask db-browser-for-sqlite
  fi

  if ask "Do you want to install DBeaver Community"; then
    success "⚙️ Installing DBeaver Community..."
    brew install --cask dbeaver-community
  fi

  if ask "🐝 Do you want to install Beekeeper Studio"; then
    success "🐝 Installing Beekeeper Studio..."
    brew install --cask beekeeper-studio
  fi
fi

if ask "Do you want to install Ganache"; then
  success "⚙️ Installing Ganache..."
  brew install --cask ganache
fi

if ask "Do you want to install Git"; then
  success "⚙️ Installing Git..."
  brew install git
  git --version

  if ask "Do you want to Git extensions (git-flow git-extras git-lfs)"; then
    success "⚙️ Installing Git extensions..."
    brew install git-flow git-extras git-lfs
  fi

  success "⚙️ Installing GitHub CLI..."
  brew install hub

  if ask "Do you want to configure Git"; then
    success "⚙️ Configuring Git..."
    git config --global user.name "${USER_EMAIL}"
    git config --global user.email "${USER_EMAIL}"

    if ask "How about GPG signing of commits"; then
      git config --global commit.gpgsign true
      read -e -p "$(success 'Enter your fingerprint: ')" GPG_FINGERPRINT
      git config --global user.signingkey "${GPG_FINGERPRINT}"
    fi
  fi

  if ask "How about aliases for Git"; then
    git config --global alias.unstage "reset HEAD --"
    git config --global alias.last "log -1 HEAD"
    git config --global alias.ci "commit"
    git config --global alias.cia "commit --amend"
    git config --global alias.cim "commit -m"
    git config --global alias.cis "commit -S"
    git config --global alias.civ "commit -v"
    git config --global alias.co "checkout"
    git config --global alias.cp "cherry-pick"
    git config --global alias.d "diff"
    git config --global alias.newb "checkout -b"
    git config --global alias.r "remote"
    git config --global alias.rv "remote -v"
    git config --global alias.rb "rebase"
    git config --global alias.tree "log --graph --oneline --all"
    git config --global alias.undo "reset --mixed HEAD^"
  fi

  if ask "Do you want to install Sourcetree"; then
    success "🌳 Installing Sourcetree"
    brew install --cask sourcetree
  fi
else
  warning "Skipping installation of git..."
fi

if ask "❤️ Do you want to install the GNU software collection?"; then
  # See: https://www.gnu.org/software/coreutils/
  if ask "Do you want to install GNU coreutils"; then
    success "⚙️ Installing GNU coreutils..."
    brew install --force-bottle coreutils
  else
    warning "Skipping installation of GNU coreutils..."
  fi

  # See: https://www.gnu.org/software/diffutils/
  if ask "Do you want to install GNU diffutils"; then
    success "⚙️ Installing GNU diffutils..."
    brew install --force-bottle diffutils
  else
    warning "Skipping installation of GNU diffutils..."
  fi

  # See: https://savannah.gnu.org/projects/which/
  if ask "Do you want to install GNU which"; then
    success "⚙️ Installing GNU which..."
    brew install gnu-which --with-default-names
  else
    warning "Skipping installation of GNU which..."
  fi

  # See: https://www.gnu.org/software/sed/
  if ask "Do you want to install GNU sed"; then
    success "⚙️ Installing GNU sed..."
    brew install gnu-sed --with-default-names
  else
    warning "Skipping installation of GNU sed..."
  fi

  # See: https://www.gnu.org/software/findutils/
  if ask "🔍 Do you want to install GNU findutils"; then
    success "🔍 Installing GNU findutils (find, locate, updatedb, and xargs)..."
    brew install --force-bottle findutils --with-default-names
  else
    warning "Skipping installation of findutils..."
  fi

  # See: https://www.gnu.org/software/indent/
  if ask "Do you want to install GNU Indent"; then
    success "⚙️ Installing GNU Indent..."
    brew install gnu-indent
  else
    warning "Skipping installation of GNU indent..."
  fi

  # See: https://www.gnu.org/software/grep/
  if ask "🔍 Do you want to install GNU grep"; then
    success "🔍 Installing GNU grep..."
    brew install grep --with-default-names
  else
    warning "Skipping installation of GNU grep..."
  fi
fi

if ask "🗜 Do you want to install compression/decompression tools"; then
  success "🗜 Installing The Unarchiver..."
  brew install --cask the-unarchiver

  success "🗜 Install GNU tar..."
  brew install gnu-tar --with-default-names

  success "🗜 Installing unrar, xz and gzip..."
  brew install unrar xz gzip
else
  warning "Skipping installation of compression/decompression tools..."
fi

if ask "💡 Do you want to install various programming languages"; then
  if ask "🐍 Do you want to install Python 3"; then
    success "🐍 Installing Python..."
    brew install python@3.9 ipython pyenv
    python --version
    pyenv --version
  fi

  if ask "🦀 Do you want to install Rust"; then
    success "🦀 Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source ~/.cargo/env
    rustup default stable
    rustup update
    rustc --version
  fi

  if ask "Do you want to install Golang"; then
    success "⚙️ Installing Golang..."
    brew install golang
  fi

  if ask "Do you want to install Erlang"; then
    success "⚙️ Installing Erlang..."
    brew install erlang rebar3
  fi

  if ask "🧪 Do you want to install Elixir"; then
    success "🧪 Installing Elixir..."
    brew install elixir
    iex --version
  fi

  if ask "☕️️ Do you want to install Java"; then
    success "☕️️ Installing Java..."
    brew install --cask java
    java --version
  fi

  if ask "Do you want to install Clojure"; then
    success "🍺 Homebrew: tap clojure/tools..."
    brew tap clojure/tools
    brew update

    success "⚙️ Installing Clojure..."
    brew install clojure/tools/clojure leiningen
  fi
else
  warning "Skipping installation of programming languages..."
fi

if ask "Do you want to install cryptocurrencies-related software"; then
  success "⚙️ Installing Binance..."
  brew install --cask binance

  if ask "Do you have Ledger"; then
    success "⚙️ Installing Ledger Live..."
    brew install --cask ledger-live
  fi
fi

if ask "Do you want to install fonts"; then
  success "🍺 Homebrew: tap caskroom/fonts..."
  brew tap caskroom/fonts
  brew update

  success "⚙️ Installing fonts..."
  fonts=(
    font-hasklig
    font-fira-code
    font-hack-nerd-font
    font-anonymous-pro
    font-inconsolidata
  )
  brew install --cask "${fonts[@]}"
fi

if ask "🛡 Do you want to install privacy and security software"; then
  if ask "Do you want to install Tor Browser"; then
    brew install --cask tor-browser
  fi

  if ask "🔒 Do you want to install GPG Suite"; then
    success "🔒 Installing GPG Suite..."
    brew install --cask gpg-suite
  fi
  if ask "Do you want to install OpenSSH"; then
    success "🔒 Installing OpenSSH..."
    brew install openssh
  fi
  if ask "Do you want to install OpenSSL"; then
    success "🔒 Installing OpenSSL..."
    brew install openssl
  fi
  if ask "Do you want to install 1Password"; then
    success "⚙️ Installing 1Password..."
    brew install --cask 1password
  fi
  if ask "Do you want to install Authy"; then
    success "⚙️ Installing Authy..."
    brew install --cask authy
  fi
  if ask "🐻 Do you want to install TunnelBear"; then
    success "🐻 Installing TunnelBear..."
    brew install --cask tunnelbear
  fi
  if ask "Do you want to install NordVPN"; then
    success "⚙️ Installing NordVPN..."
    brew install --cask nordvpn
  fi
  if ask "☁️ Do you want to install CloudFlare Warp"; then
    success "☁️ Installing CloudFlare Warp..."
    brew install --cask cloudflare-warp
  fi
else
  warning "Skipping installation of privacy and security software..."
fi

if ask "🛠 Do you want to install JetBrain's IDEs"; then
  if ask "Will you install them manually, using JetBrain Toolbox"; then
    success "⚙️ Installing JetBrains Toolbox..."
    brew install --cask jetbrains-toolbox
  else
    if ask "🛠 Do you want to install PyCharm"; then
      success "⚙️ Installing PyCharm Professional..."
      brew install --cask pycharm
    fi

    if ask "🛠 Do you want to install WebStorm"; then
      success "⚙️ Installing WebStorm..."
      brew install --cask webstorm
    fi

    if ask "🛠 Do you want to install GoLand"; then
      success "⚙️ Installing GoLand..."
      brew install --cask goland
    fi

    if ask "🛠 Do you want to install CLion"; then
      success "⚙️ Installing CLion..."
      brew install --cask clion
    fi

    if ask "🛠 Do you want to install RubyMine"; then
      success "⚙️ Installing RubyMine..."
      brew install --cask rubymine
    fi

    if ask "🛠 Do you want to install DataGrip"; then
      success "⚙️ Installing DataGrip..."
      brew install --cask datagrip
    fi

    if ask "🛠 Do you want to IntelliJ IDEA Ultimate"; then
      success "⚙️ Installing IntelliJ IDEA Ultimate..."
      brew install --cask intellij-idea
    fi
  fi
fi

if ask "🔬 Do you want to install network/traffic analysis tools"; then
  success "🔬 Installing network/traffic analysis tools"
  utils=(
    mtr
    tmux
    ngrok
    hping
    telnet
    tcpdump
    tcpflow
    tcptrace
    tcpreplay
    prettyping
  )

  for package in "${utils[@]}"; do
    success "⚙️ Installing ${package}..."
    brew install "${package}"
  done

  if ask "Do you want to install Wireshark"; then
    success "⚙️ Installing Wireshark..."
    brew install --cask wireshark
  fi

  if ask "Do you want to install Angry IP Scanner"; then
    success "⚙️ Installing Angry IP Scanner..."
    brew install --cask angry-ip-scanner
  fi
fi

if ask "🛠 Do you want to install toolset for frontend development"; then
  success "🛠 Installing Node and TypeScript..."
  brew install nvm node typescript deno
fi

if ask "🛠 Do you want to other CLI-tools"; then
  success "🛠 Installing misc developer CLI-tools..."
  dev_utils=(
    jq
    fzf
    bat
    wget
    tree
    trash
    tokei
    rename
    httpie
    neovim
    ffmpeg
    libjpeg
    gettext
    readline
    hadolint
    automake
    readline
    hyperfine
    shellcheck
    screenfetch
  )

  for package in "${dev_utils[@]}"; do
    success "⚙️ Installing ${package}..."
    brew install "${package}"
  done
fi

if ask "🐠 Do you want to install fish"; then
  success "🐠 Installing fish..."
  brew install fish

  success "🐠 Setting up fish as default..."
  chsh -s /usr/local/bin/fish

  success "🐠 Installing oh-my-fish..."
  curl -L https://get.oh-my.fish | fish

  success "🐠 Changing theme..."
  omf theme idan
else
  warning "Skipping installation of fish..."
fi

brew cleanup

if ask "Do you want to change the default settings of your macOS"; then
  success "💻 Changing macOS's settings..."

  # Avoids appearing your name in local networks and in various preference files
  sudo scutil --set ComputerName "${COMPUTER_NAME}"
  sudo scutil --set HostName "${HOSTNAME}"
  sudo scutil --set LocalHostName "${LOCAL_HOSTNAME}"

  # Sleep the display after 15 minutes
  sudo pmset -a displaysleep 10

  # Disable machine sleep while charging
  sudo pmset -c sleep 0

  # Set machine sleep to 5 minutes on battery
  sudo pmset -b sleep 5

  # Disable shit I hate.
  defaults write com.apple.dashboard mcx-disabled -boolean YES

  # This line deactivates rubber scrolling:
  defaults write -g NSScrollViewRubberbanding -int 0

  # Scrollbars visible when scrolling:
  defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

  # Maximize windows on double clicking them:
  defaults write -g AppleActionOnDoubleClick 'Maximize'

  # Require password immediately after sleep or screen saver begins
  defaults write com.apple.screensaver askForPassword -int 1
  defaults write com.apple.screensaver askForPasswordDelay -int 0

  # Don’t send search queries to Apple
  defaults write com.apple.Safari UniversalSearchEnabled -bool false
  defaults write com.apple.Safari SuppressSearchSuggestions -bool true

  # Improve security
  defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
  defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles -bool false

  # Enable the Develop menu and the Web Inspector in Safari
  defaults write com.apple.Safari IncludeDevelopMenu -bool true
  defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
  defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

  # Show the full URL in the address bar (note: this still hides the scheme)
  defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

  # Set Safari’s home page to `about:blank` for faster loading
  defaults write com.apple.Safari HomePage -string "about:blank"

  # Disable Safari’s thumbnail cache for History and Top Sites
  defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

  # Enable Safari’s debug menu
  defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

  # Disable AutoFill
  defaults write com.apple.Safari AutoFillFromAddressBook -bool false
  defaults write com.apple.Safari AutoFillPasswords -bool false
  defaults write com.apple.Safari AutoFillCreditCardData -bool false
  defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

  # Enable “Do Not Track”
  defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

  # Update extensions automatically
  defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

  # Show Finder path bar:
  defaults write com.apple.finder ShowPathbar -bool true

  # Show the main window when launching Activity Monitor
  defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

  # Disable autocorrect:
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

  # Disable auto-capitalization:
  defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

  # Notification dismiss timeout:
  defaults write com.apple.notificationcenterui bannerTime -int 4

  # Turn on app auto-update
  defaults write com.apple.commerce AutoUpdate -bool true

  # Automatically download apps purchased on other Macs
  defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1

  # Download newly available updates in background
  defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

  # Auto-play videos when opened with QuickTime Player
  defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool true

  # Sort Activity Monitor results by CPU usage
  defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
  defaults write com.apple.ActivityMonitor SortDirection -int 0

  # Show all processes in Activity Monitor
  defaults write com.apple.ActivityMonitor ShowCategory -int 0

  # Prevent Time Machine from prompting to use new hard drives as backup volume
  defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

  # Don’t display the annoying prompt when quitting iTerm
  defaults write com.googlecode.iterm2 PromptOnQuit -bool false

  # Only use UTF-8 in Terminal.app
  defaults write com.apple.terminal StringEncodings -array 4

  # Don’t show recent applications in Dock
  defaults write com.apple.dock show-recents -bool false

  # Speed up Mission Control animations
  defaults write com.apple.dock expose-animation-duration -float 0.1

  # Show indicator lights for open applications in the Dock
  defaults write com.apple.dock show-process-indicators -bool true

  # Minimize windows into their application’s icon
  defaults write com.apple.dock minimize-to-application -bool true

  # Show the ~/Library folder
  chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

  # Disable the warning before emptying the Trash
  defaults write com.apple.finder WarnOnEmptyTrash -bool false

  # Empty Trash securely by default
  defaults write com.apple.finder EmptyTrashSecurely -bool true

  # Avoid creating .DS_Store files on network or USB volumes
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

  # Disable the warning when changing a file extension
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

  # When performing a search, search the current folder by default
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

  # Keep folders on top when sorting by name
  defaults write com.apple.finder _FXSortFoldersFirst -bool true

  # Display full POSIX path as Finder window title
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

  # Show all filename extensions in Finder
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  # Save screenshots in PNG format
  defaults write com.apple.screencapture type -string "png"

  # Save screenshots to the desktop
  defaults write com.apple.screencapture location -string "${HOME}/Desktop"

  # Disable crash reporter
  defaults write com.apple.CrashReporter DialogType none

  # Don't save documents to iCloud by default
  defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

  # Show icons for hard drives, servers, and removable media on the desktop
  defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
  defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

  killall Finder
  killall Dock
fi

success '✨ Done!'
