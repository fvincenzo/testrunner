FROM debian:latest

USER root

SHELL ["/bin/bash", "-c"]

RUN DEBIAN_FRONTEND=noninteractive apt -qq -y update && \
    DEBIAN_FRONTEND=noninteractive apt -qq -y --no-install-recommends --no-install-suggests upgrade && \
    DEBIAN_FRONTEND=noninteractive apt -qq -y --no-install-recommends --no-install-suggests install \
    git build-essential procps ca-certificates kmod

RUN mkdir -p /testrunner/
COPY . /testrunner/

ENV PATH /testrunner/bin:$PATH
ENV TESTS_WORKDIR /testrunner/

WORKDIR "/testrunner"
VOLUME [ "/testrunner/html" ]
VOLUME [ "/testrunner/tests/mmtests/work/log" ]

CMD ["/usr/bin/env", "bash", "-c", "/testrunner/bin/run.sh", "--", "-m"]


