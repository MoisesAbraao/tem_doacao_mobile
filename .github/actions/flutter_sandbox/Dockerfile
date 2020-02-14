FROM ubuntu:latest

# install env dependencies
RUN apt update && \
    apt install curl -y && \
    apt install unzip -y && \
    apt install git -y

# download flutter
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1

# include flutter to env
ENV PATH="/flutter/bin:${PATH}"

# inspect flutter installation
RUN flutter doctor
