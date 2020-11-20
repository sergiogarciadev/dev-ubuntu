#!/bin/bash

set -e

# Ensure apt is in non-interactive to avoid prompts
export DEBIAN_FRONTEND=noninteractive

#
# Set en_US locale
#
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen 
locale-gen

#
# Create non root user
#
USERNAME=ubuntu
USER_UID=1000
USER_GID=1000

# Create or update a non-root user to match UID/GID - see https://aka.ms/vscode-remote/containers/non-root-user.
if id -u $USERNAME > /dev/null 2>&1; then
  # User exists, update if needed
  if [ "$USER_GID" != "$(id -G $USERNAME)" ]; then
    groupmod --gid $USER_GID $USERNAME
    usermod --gid $USER_GID $USERNAME
  fi

  if [ "$USER_UID" != "$(id -u $USERNAME)" ]; then
    usermod --uid $USER_UID $USERNAME
  fi
else
  # Create user
  groupadd --gid $USER_GID $USERNAME
  useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME
fi

echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/99_$USERNAME

#
# Use tty for GPG
#
echo '' >> /etc/bash.bashrc 
echo '# GPG tty for signing commit' >> /etc/bash.bashrc 
echo 'export GPG_TTY=$(tty)' >>/etc/bash.bashrc 
echo '' >> /etc/bash.bashrc 
