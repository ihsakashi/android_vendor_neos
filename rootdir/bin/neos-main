#!/usr/bin/bash

# useful for not pissing off vim
mount -o remount,rw /

# run once (if zygote is restarted we might get here multiple times)
if mkdir /runonce; then
  echo "running once"
else
  exit 0
fi

# setup CPU set for all android tasks
mkdir /dev/cpuset/android
echo 0 > /dev/cpuset/android/cpus
echo 0 > /dev/cpuset/android/mems

# migrate all tasks
while read i; do echo $i > /dev/cpuset/android/tasks; done < /dev/cpuset/tasks 2>/dev/null

# NEOS application CPU set
# the installed app may set up its own realtime reservations within this set
mkdir /dev/cpuset/app
echo 0-3 > /dev/cpuset/app/cpus
echo 0 > /dev/cpuset/app/mems

echo $$ > /dev/cpuset/app/tasks
# ************ (our parent, tmux, also gets all the cores) ************
echo $PPID > /dev/cpuset/app/tasks

rm -f /data/params/d/AthenadPid

while true; do
  if [ -f /data/data/com.termux/files/continue.sh ]; then
    exec /data/data/com.termux/files/continue.sh
  fi

  while [ ! -f /system/neos/installer ]; do
    echo "waiting for installer"
    sleep 1
  done

  chmod +x /system/neos/installer
  /system/neos/installer
done