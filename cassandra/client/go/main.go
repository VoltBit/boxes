package main

import (
	"fmt"

	"./client"
)

func main() {
	fmt.Println("Cassandra client starting")
	client := client.NewCasssandraClient()
	client.Start()
}
