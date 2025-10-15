FROM ubuntu:latest
RUN mkdir solution && apt-get update && apt-get install -y make jq gcc bash
WORKDIR /solution
COPY . .
RUN make
CMD ["./build/wordcount"]