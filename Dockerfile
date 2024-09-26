FROM debian:latest

USER root

SHELL ["/bin/bash", "-c"]

RUN DEBIAN_FRONTEND=noninteractive apt -qq -y update && \
    DEBIAN_FRONTEND=noninteractive apt -qq -y --no-install-recommends --no-install-suggests upgrade

RUN mkdir -p /testrunner/
COPY . /testrunner/

ENV PATH /testrunner/bin:$PATH
ENV TESTS_WORKDIR /testrunner/

WORKDIR "/testrunner/html"
VOLUME [ "/testrunner/html" ]

CMD ["sh", "run.sh", "-m"]


