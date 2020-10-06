package main

import (
	"bytes"
	"fmt"
	"os/exec"
)

func testRedisCLI() {
	var stdout, stderr bytes.Buffer

	defaultArgs := []string{"-h", "127.0.0.1", "-p", "7000"}
	// args := append(defaultArgs, []string{"cluster", "info"}...)
	// args := append(defaultArgs, []string{"cluster", "myid"}...)
	args := append(defaultArgs, []string{"cluster", "nodes"}...)
	// args := append(defaultArgs, []string{"info"}...)

	// args := append(defaultArgs, []string{"infoooo"}...)
	// args := append(defaultArgs, []string{"info", "serverrr"}...)
	cmd := exec.Command("../redis-cli", args...)
	cmd.Stderr = &stderr
	cmd.Stdout = &stdout
	fmt.Printf("Running %s\n", cmd)
	err := cmd.Run()

	fmt.Println("[err]:", err)
	fmt.Println("[stdout]:", stdout.String())
	fmt.Println("[stderr]:", stderr.String())
}

func main() {
	testRedisCLI()
}
