node=7000
count=6
i=0

if [[ $OSTYPE == "darwin"* ]]; then
  BINPATH=../bin/darwin
elif [[ $OSTYPE == "linux-gnu"* ]]; then
  BINPATH=../bin/linux-gnu
fi

echo > pids

echo "Starting Redis..."
until [ $i -eq $count ]
do
  echo $node
  ((i=i+1))
  mkdir $node
  cd $node

  echo "port $node
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
appendonly no
save ""
aclfile users.acl" > redis.conf

  echo "user default on nopass ~* +@all" > users.acl

  ../$BINPATH/redis-server redis.conf > /dev/null &
  PID=$!
  echo $PID >> ../pids
  cd - > /dev/null
  ((node=node+1))
done

sleep 2

echo "Setting up cluster..."
$BINPATH/redis-cli --cluster create 127.0.0.1:7000 127.0.0.1:7001 127.0.0.1:7002 --cluster-yes

sleep 1

$BINPATH/redis-cli --cluster add-node 127.0.0.1:7003 127.0.0.1:7000 --cluster-slave
$BINPATH/redis-cli --cluster add-node 127.0.0.1:7004 127.0.0.1:7000 --cluster-slave
$BINPATH/redis-cli --cluster add-node 127.0.0.1:7005 127.0.0.1:7000 --cluster-slave
