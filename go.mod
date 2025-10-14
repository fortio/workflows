module github.com/fortio/workflows

// Just to test linters, we don't actually require anything recent here.
go 1.24

// toolchain go1.22.3 // this shouldn't be necessary - see https://github.com/golang/go/issues/66175#issuecomment-2010343876

require (
	fortio.org/log v1.18.1
	fortio.org/scli v1.18.1
)

require (
	fortio.org/cli v1.12.2 // indirect
	fortio.org/dflag v1.9.2 // indirect
	fortio.org/duration v1.0.4 // indirect
	fortio.org/sets v1.3.0 // indirect
	fortio.org/struct2env v0.4.2 // indirect
	fortio.org/version v1.0.4 // indirect
	github.com/fsnotify/fsnotify v1.8.0 // indirect
	github.com/kortschak/goroutine v1.1.3 // indirect
	golang.org/x/crypto/x509roots/fallback v0.0.0-20250203165127-fa5273e46196 // indirect
	golang.org/x/sys v0.35.0 // indirect
)
