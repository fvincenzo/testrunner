#!/usr/bin/env bash

clone_or_pull() {
	if cd "$2" && [[ -d .git ]]; then git pull; cd -; else git clone "$1" "$2"; fi
}

init()
{
	mkdir -p tests
	cd tests
}

mmtests()
{
	init

	echo "Running mmtests..."
	
	# Clone or pull from mmtests
	clone_or_pull https://github.com/gormanm/mmtests.git mmtests

	cd mmtests

	# Run tests normal and container
	./run-mmtests.sh --no-monitor --config configs/config-workload-kernbench-max 6.8.0-vanilla
	./run-container.sh --no-monitor --config configs/config-workload-kernbench-max 6.8.0-vanilla-docker

	# Compare results
	cd work/log
	../../compare-kernels.sh --format html --output-dir $TESTS_WORKDIR > $TESTS_WORKDIR/index.html
}

lkp()
{
	init

	echo "Running lkp..."
}

while getopts ":l:m" option; do
	case $option in
		m) mmtests
		   exit;;
	   	l) lkp
		   exit;;
   esac
done
