# Variables
BUILD_DIR := build
BUILD_MANIFEST := wildcard
BUILD_OUT := -o ${BUILD_DIR}/wildcard

# Targets
all: package files homedirectory

package: 	compile
					tar -czf ${BUILD_DIR}/wildcard.tar.gz -C ${BUILD_DIR} ${BUILD_MANIFEST}

compile: 	wildcard.go
					mkdir -p ${BUILD_DIR}
					rm -rf ${BUILD_DIR}/*
					go build ${BUILD_OUT}/wildcard

files: 	*.go
				echo $?

homedirectory: ~
				echo $?

test:	
					go test ./...

clean:
					rm -rf ${BUILD_DIR}