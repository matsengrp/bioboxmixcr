FROM matsengrp/cpp
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN apt-get update && apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y \
    oracle-java7-installer \
    libncurses5-dev \
    libxml2-dev \
    libxslt1-dev \
    r-base \
    zlib1g-dev

COPY . /mixcr
WORKDIR /mixcr
ADD run.sh /usr/local/bin/
RUN cd /usr/local/bin && chmod 700 run.sh
ENTRYPOINT ["./run.sh"]
