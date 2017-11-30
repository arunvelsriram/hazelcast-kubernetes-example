FROM library/openjdk:8

WORKDIR /opt/app

ADD ./build/libs/hazelcast-kubernetes-example-1.0-SNAPSHOT-all.jar .

CMD java -jar hazelcast-kubernetes-example-1.0-SNAPSHOT-all.jar