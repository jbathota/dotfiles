# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH for neovim
if [ -d "/opt/nvim-linux64/bin" ] ; then
	PATH="$PATH:/opt/nvim-linux64/bin"
fi

# set Android tools path
if [ -d "$HOME/android_sdk" ] ; then
	export ANDROID_HOME="$HOME/android_sdk"
	PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/35.0.1:$ANDROID_HOME/emulator:$ANDROID_HOME/extras/google/auto"
fi

# set PATH to node js
if [ -d "$HOME/.local/node" ] ; then
    PATH="$HOME/.local/node/bin:$PATH"
fi

# set PATH to llvm and clang tools
if [ -d "/usr/lib/llvm-19/" ] ; then
    PATH="/usr/lib/llvm-19/bin:$PATH"
fi

# set these for running Android studio
if [ -d "$HOME/.local/android-studio" ] ; then
    export STUDIO_JDK=/usr/lib/jvm/java-21-openjdk-amd64/
    export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64/
    PATH="$PATH:$HOME/.local/android-studio/bin/"
fi

# for gradle
if [ -d "/opt/gradle/gradle-8.11" ] ; then
	PATH="$PATH:/opt/gradle/gradle-8.11/bin"
fi

