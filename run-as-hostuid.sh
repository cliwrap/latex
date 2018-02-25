#!/bin/sh
# Copyright (C) 2018 Wesley Tanaka
#
# This file is part of docker-ubuntu-1604-latex
#
# docker-ubuntu-1604-latex is free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation, either version 3 of
# the License, or (at your option) any later version.
#
# docker-ubuntu-1604-latex is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with docker-ubuntu-1604-latex.  If not, see
# <http://www.gnu.org/licenses/>.
HOSTUSERNAME=hostuser
HOSTHOMEDIR="/home/$HOSTUSERNAME"

if [ -z "$WORKDIR" ]; then
  WORKDIR=/work
fi

if [ ! -d "$WORKDIR" ]; then
  echo 'Mount '"$WORKDIR"', e.g. with: -v "`pwd`:/work"'
  exit 2
fi

if [ -z "$HOSTUID" ]; then
  echo 'Set HOSTUID, e.g. with: -e "HOSTUID=`id -u`"'
  exit 2
fi
# TODO: This currently does not preserve the $GID from outside the
# container, and could be enhanced to do so.
useradd -u "$HOSTUID" "$HOSTUSERNAME"
mkdir "$HOSTHOMEDIR"
chown -R "$HOSTUSERNAME":"$HOSTUSERNAME" "$HOSTHOMEDIR"

# From http://www.etalabs.net/sh_tricks.html
save () {
  for i do printf %s\\n "$i" | sed "s/'/'\\\\''/g;1s/^/'/;\$s/\$/' \\\\/" ; done
  echo " "
}

usercommand=$(save "$@")

cd "$WORKDIR"
exec su - "$HOSTUSERNAME" -c "cd ${WORKDIR}; $usercommand"
