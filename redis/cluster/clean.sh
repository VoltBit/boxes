cat pids | xargs kill -9

node=7000
count=6
i=0

until [ $i -eq $count ]
do
  echo "del $node..."
  rm -rf $node
  ((i=i+1))
  ((node=node+1))
done

rm pids
