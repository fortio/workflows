module github.com/fortio/workflows

go 1.21

// toolchain go1.22.3 // this shouldn't be necessary - see https://github.com/golang/go/issues/66175#issuecomment-2010343876

require (
	fortio.org/log v1.17.2
	fortio.org/scli v1.16.0
)

require (
	fortio.org/cli v1.10.0 // indirect
	fortio.org/dflag v1.8.0 // indirect
	fortio.org/sets v1.3.0 // indirect
	fortio.org/struct2env v0.4.2 // indirect
	fortio.org/version v1.0.4 // indirect
	github.com/fsnotify/fsnotify v1.8.0 // indirect
	github.com/kortschak/goroutine v1.1.2 // indirect
	golang.org/x/crypto/x509roots/fallback v0.0.0-20250203165127-fa5273e46196 // indirect
	golang.org/x/sys v0.30.0 // indirect
)
