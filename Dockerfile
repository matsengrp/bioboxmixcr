FROM matsengrp/cpp
#RUN apt-get update
#RUN apt-get install -y \	
#	libroot-bindings-python-dev \	
#	libroot-graf2d-postscript5.34 

COPY . /mixcr
WORKDIR /mixcr

#RUN echo ${PWD}

ADD run.sh /usr/local/bin/
#RUN cd /usr/local/bin

#RUN echo ${PWD}
#RUN ls

ENTRYPOINT ["./run.sh"]
