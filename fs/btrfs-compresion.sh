#!/bin/bash

compression=(zlib lzo zstd)

btrfs filesystem defragment -r -v -czstd "$1"

sub_file() {
	btrfs property set "" <file >compression
}
