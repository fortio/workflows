module github.com/fortio/workflows

go 1.21

// toolchain go1.22.3 // this shouldn't be necessary - see https://github.com/golang/go/issues/66175#issuecomment-2010343876

require fortio.org/scli v1.15.3

require (
	fortio.org/cli v1.9.2 // indirect
	fortio.org/dflag v1.7.3 // indirect
	fortio.org/log v1.17.1 // indirect
	fortio.org/sets v1.2.0 // indirect
	fortio.org/struct2env v0.4.1 // indirect
	fortio.org/version v1.0.4 // indirect
	github.com/fsnotify/fsnotify v1.7.0 // indirect
	github.com/kortschak/goroutine v1.1.2 // indirect
	golang.org/x/crypto/x509roots/fallback v0.0.0-20240806160748-b2d3a6a4b4d3 // indirect
	golang.org/x/exp v0.0.0-20240808152545-0cdaa3abc0fa // indirect
	golang.org/x/sys v0.25.0 // indirect
)
