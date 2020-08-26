package node

import (
	"fmt"
	"log"
	"sync"

	"github.com/streadway/amqp"
)

func failOnError(err error, msg string) {
	if err != nil {
		log.Fatalf("%s: %s", msg, err)
	}
}

type RabbitMQNode struct {
	conn *amqp.Connection
	ch   *amqp.Channel
	q    *amqp.Queue
}

func NewRabbitMQNode(msgQueue string) *RabbitMQNode {
	conn, err := amqp.Dial("amqp://guest:guest@localhost:5672/")
	failOnError(err, "Could not connect to RabbitMQ")

	ch, err := conn.Channel()
	failOnError(err, "Could not create channel")

	q, err := ch.QueueDeclare(
		msgQueue, // name
		false,    // durable
		false,    // delete when unused
		false,    // exclusive
		false,    // no-wait
		nil,      // arguments
	)
	failOnError(err, "Failed to declare a queue")
	return &RabbitMQNode{
		conn: conn,
		ch:   ch,
		q:    &q,
	}
}

func makeSender(wg *sync.WaitGroup) {
	defer wg.Done()
	fmt.Println("Making sender...")
	node := NewRabbitMQNode("msg-queue-1")
	defer node.ch.Close()
	defer node.conn.Close()
	body := "Hello World!"
	err := node.ch.Publish(
		"",          // exchange
		node.q.Name, // routing key
		false,       // mandatory
		false,       // immediate
		amqp.Publishing{
			ContentType: "text/plain",
			Body:        []byte(body),
		})
	failOnError(err, "Failed to publish a message")
}

func makeReceiver(wg *sync.WaitGroup) {
	defer wg.Done()
	fmt.Println("Making receiver...")
	node := NewRabbitMQNode("msg-queue-1")
	defer node.ch.Close()
	defer node.conn.Close()
	msgs, err := node.ch.Consume(
		node.q.Name, // queue
		"",          // consumer
		true,        // auto-ack
		false,       // exclusive
		false,       // no-local
		false,       // no-wait
		nil,         // args
	)
	failOnError(err, "Failed to register a consumer")

	forever := make(chan bool)

	go func() {
		for d := range msgs {
			log.Printf("Received a message: %s", d.Body)
		}
	}()

	log.Printf(" [*] Waiting for messages. To exit press CTRL+C")
	<-forever
}

func CreateNodes(nodeSetup map[string]int) {
	var wg sync.WaitGroup
	wg.Add(2)
	go makeSender(&wg)
	go makeReceiver(&wg)
	wg.Wait()
}
