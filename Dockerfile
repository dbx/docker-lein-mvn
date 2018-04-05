FROM pandeiro/docker-lein

RUN apt-get update && apt-get install -y mvn bash
RUN mvn

ENTRYPOINT ["bash"]
