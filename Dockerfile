FROM matsengrp/cpp

#Download relevant packages 
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN apt-get update && apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y \
    oracle-java7-installer 

COPY . /mixcr
WORKDIR /mixcr
ADD run.sh /usr/local/bin/
RUN cd /usr/local/bin && chmod 700 run.sh

#sets the shellscript file to be the entrypoint
ENTRYPOINT ["./run.sh"]
