RUN apt-get install -y \	
	libroot-bindings-python-dev \	
	libroot-graf2d-postscript5.34 \

ADD run.sh /usr/local/bin

ENTRYPOINT['run.sh']
