package main

import node "./node"

/*
Design of the test client
- Have a configurable number of processes that subscribe and publish to the RabbitMQ client
-
*/

func main() {
	node.CreateNodes(map[string]int{"publisher": 2, "consumer": 2})
}
