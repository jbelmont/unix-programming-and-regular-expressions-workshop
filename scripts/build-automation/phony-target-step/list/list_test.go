package list

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestShowMeList(t *testing.T) {
	list := showMeList()
	assert.Equal(t, list["$?"], "$?", "they should be equal")
	assert.Equal(t, list["~"], "list home directory", "should list home directory")
	assert.Equal(t, list["$*"], "The stem with which an implicit rule matches", "a phrase")
}
