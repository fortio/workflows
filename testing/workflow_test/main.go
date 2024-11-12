// Just to minimally exercise some of the go actions
package main

import (
	"runtime"

	"fortio.org/log"
	"fortio.org/scli"
)

func main() {
	scli.ServerMain()
	_, file, _, ok := runtime.Caller(2)
	log.Infof("Just mnd check: %v %v", file, ok)
}
