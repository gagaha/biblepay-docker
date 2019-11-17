FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils \
	libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev \
	libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler \
	git curl build-essential libtool autotools-dev automake pkg-config python3 bsdmainutils cmake && \
	apt-get install -y software-properties-common &&  add-apt-repository ppa:bitcoin/bitcoin && apt-get update && apt-get install -y libdb4.8-dev libdb4.8++-dev

LABEL version=1.4.5.2

RUN git clone http://github.com/biblepay/biblepay-evolution && \
	prefix=x86_64-pc-linux-gnu && cd biblepay-evolution/depends && make && cd .. && ./autogen.sh && ./configure --without-gui --disable-bench --disable-tests --prefix `pwd`/depends/x86_64-pc-linux-gnu && make && \
	mv src/biblepayd src/biblepay-cli src/biblepay-tx /usr/bin/ && \
	rm -rf biblepay-evolution && apt-get autoremove -y && apt-get remove --purge -y git make build-essential autoconf libtool libdb4.8-dev libdb4.8++-dev libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools \
        libevent-dev libprotobuf-dev protobuf-compiler automake bsdmainutils libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev \
	libssl-dev pkg-config  && \
        apt-get clean && rm -rf /var/lib/{apt,dpkg,cache,log}/

VOLUME /root/.biblepayevolution

COPY ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["biblepayd", "-printtoconsole"]
