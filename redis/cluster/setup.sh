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

# admin: adminpass # password protected admin, used by the operator
# testuser: testpass # for testing clients
# rdcuser: rdcpass # used by the replicas

  echo "port $node
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
appendonly no
save ""
masteruser rdcuser
masterauth rdcpass
aclfile users.acl" > redis.conf

  # echo "user default on nopass ~* +@all" > users.acl
  echo "user default off nopass -@all
user admin on #713bfda78870bf9d1b261f565286f85e97ee614efe5f0faf7c34e7ca4f65baca ~* &* +@all
user testuser on #13d249f2cb4127b40cfa757866850278793f814ded3c587fe5889e889a7a9f6c ~testkey:* &* -@all +get +set
user rdcuser on #400f9f96b4a343f4766d29dbe7bee178d7de6e186464d22378214c0232fb38ca &* -@all +replconf +ping +psync" > users.acl

  ../$BINPATH/redis-server redis.conf > /dev/null &
  PID=$!
  echo $PID >> ../pids
  cd - > /dev/null
  ((node=node+1))
done

sleep 2

echo "Setting up cluster..."

$BINPATH/redis-cli --cluster create 127.0.0.1:7000 127.0.0.1:7001 127.0.0.1:7002 --cluster-yes --user admin --pass adminpass

sleep 1

$BINPATH/redis-cli --cluster add-node 127.0.0.1:7003 127.0.0.1:7000 --cluster-slave --user admin --pass adminpass
$BINPATH/redis-cli --cluster add-node 127.0.0.1:7004 127.0.0.1:7000 --cluster-slave --user admin --pass adminpass
$BINPATH/redis-cli --cluster add-node 127.0.0.1:7005 127.0.0.1:7000 --cluster-slave --user admin --pass adminpass
