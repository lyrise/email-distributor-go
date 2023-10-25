package main

import (
	"encoding/json"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

var (
	version  string
	revision string
	build    string
)

type Event struct {
	sqsEvent *events.SQSEvent
}

func (e *Event) UnmarshalJSON(b []byte) error {
	sqsEvent := &events.SQSEvent{}
	err := json.Unmarshal(b, sqsEvent)
	if err == nil {
		e.sqsEvent = sqsEvent
		return nil
	}

	return err
}

func hello(event Event) error {
	println("Hello World")
	return nil
}

func main() {
	lambda.Start(hello)
}
