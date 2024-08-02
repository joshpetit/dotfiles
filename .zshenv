export PATH=$HOME/.local/bin/:$PATH
export NVM_DIR="$HOME/.nvm"
export NVM_INIT_FILE=/usr/share/nvm/init-nvm.sh
export PATH=$HOME/.local/share/scripts/:$PATH
export PATH=$HOME/.yarn/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/go/bin:$PATH
#export JAVA_HOME=/usr/lib/jvm/java-8-openjdk/jre
# export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
 export JAVA_HOME=/usr/lib/jvm/java-17-openjdk/
# export JAVA_HOME=/Users/joshiep/.sdkman/candidates/java/17.0.4.1-tem
export ZPLUG_HOME=$HOME/.local/share/zplug/
export ZPLUG_FILE=$HOME/.local/share/zplug/init.zsh
export CM_LAUNCHER=rofi

export ANDROID_SDK_ROOT='/opt/android-sdk/'
export FLUTTER_ROOT='/opt/flutter/'
export PATH=$PATH:$JAVA_HOME/bin/
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools/
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin/
export PATH=$PATH:$ANDROID_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/
export PATH=$PATH:/Users/joshiep/.toolbox/bin
export CALIBRE_USE_DARK_PALETTE=1
#export VIRSH_DEFAULT_CONNECT_URI=qemu:///system 
export PATH="$PATH":"$HOME/.pub-cache/bin"
export XDG_CONFIG_HOME=$HOME/.config/

export SDKMAN_DIR="$HOME/.sdkman"

# Begin added by argcomplete
fpath=( /usr/lib/python3.12/site-packages/argcomplete/bash_completion.d "${fpath[@]}" )
# End added by argcomplete
