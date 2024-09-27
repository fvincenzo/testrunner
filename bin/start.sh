#!/usr/bin/env bash


main ()
{
	local test_env=${TESTRUNNER_ENV:-mmtests}

	if [[ "${test_env}" == "mmtests" ]]; then
		run.sh -m
	else
		run.sh -l
	fi
}

main $@
