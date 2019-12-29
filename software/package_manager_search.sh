apk > /dev/null 2>&1
if [ $? -ne 127 ]; then
  echo 'Found apk'
fi

apt > /dev/null 2>&1
if [ $? -ne 127 ]; then
  echo 'Found apt'
fi

pacman > /dev/null 2>&1
if [ $? -ne 127 ]; then
  echo 'Found pacman'
fi
