#!/bin/bash
set -e

WORKDIR=$(pwd)
uid=1000
gid=1000

export USER=docker-user
export HOME=/home/docker-user
GROUP=$USER

usermod -u "$uid" $USER 2> /dev/null && {
  groupmod -g "$gid" $GROUP 2> /dev/null || usermod -a -G "$gid" $USER
}

chown -R "$uid:$gid" "$HOME"

chown "$uid:$gid" /proc/self/fd/{1,2}

echo "Starting with UID: $uid, GID: $gid"

exec gosu "$USER" "$@"