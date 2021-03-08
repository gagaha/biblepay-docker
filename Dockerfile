FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive

LABEL build_version="1.5.4.4"
LABEL build_date="2020-03-08"

RUN apt update && apt install -y wget unzip

RUN wget https://biblepay.org/biblepay-lin64.zip && unzip biblepay-lin64.zip

RUN rm biblepay-lin64.zip && mv biblepay* /usr/local/bin/

VOLUME /root/.biblepay

COPY ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["biblepayd", "-printtoconsole"]
