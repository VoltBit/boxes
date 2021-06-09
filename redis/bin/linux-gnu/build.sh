git clone git@github.com:redis/redis.git
cd redis
make
cp src/redis-cli ../
cp src/redis-server ../
cd ..
rm -rf redis
