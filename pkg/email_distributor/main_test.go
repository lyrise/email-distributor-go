package main_test

import (
	"testing"

	. "github.com/onsi/ginkgo/v2"
	. "github.com/onsi/gomega"
)

func TestMigration(t *testing.T) {
	RegisterFailHandler(Fail)
	RunSpecs(t, "Spec")
}

var _ = Describe("Test", func() {
	BeforeEach(func() {
	})

	AfterEach(func() {
	})

	It("simple test", Serial, func() {
	})
})
