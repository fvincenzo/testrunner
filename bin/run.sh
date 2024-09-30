#!/usr/bin/env bash

clone_or_pull() {
	if [[ -d "$2" ]] && cd "$2" && [[ -d .git ]]; then git pull; cd -; else git clone "$1" "$2"; fi
}

init()
{
	version=$(uname -r)
	date=$(date '+%Y%m%d%H%M%S')

	# Make sure we are in the TESTS_WORKDIR
	cd $TESTS_WORKDIR

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

	# Update kernbench
	sed -i -e 's/5.14/6.11/g' configs/config-workload-kernbench-max

	# Run tests
	echo "yes" | ./run-mmtests.sh --no-monitor --no-mount --config configs/config-workload-kernbench-max "${version}-linux-${date}"

	# Compare results
	cd work/log
	cp -Rf * $LOG_WORKDIR

	cd $LOG_WORKDIR
	../tests/mmtests/compare-kernels.sh --format html --output-dir $TESTS_WORKDIR > $TESTS_WORKDIR/index.html
}

lkp()
{
	init

	echo "Running lkp..."
}

main()
{
	set +x

	for arg; do
		case $arg in
			-m) mmtests && exit 0 ;;
			-l) lkp && exit 0 ;;
		esac
	done
}

main $@
