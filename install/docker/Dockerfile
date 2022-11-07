FROM ruby:latest

LABEL authors="teuton.software@proton.me"

RUN apt-get update
RUN gem install teuton
RUN gem install teuton-get
RUN mkdir /opt

EXPOSE 80

WORKDIR /opt
CMD ["/bin/bash"]
