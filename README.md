# hazelcast-kubernetes-example
An example to demonstrate Kubernetes discovery mechanism for [Hazelcast](https://hazelcast.org/) using [hazelcast-kubernetes](https://github.com/hazelcast/hazelcast-kubernetes) plugin.

## How to?

### 1. `kubectl` access

This example assumes that you have [`kubectl`](https://github.com/kubernetes/kubectl) access to your Kubernetes cluster. You can setup a Kubernetes cluster locally using [Minikube](https://github.com/kubernetes/minikube).

### 2. Create Deployment and Service

```
kubectl -f https://raw.githubusercontent.com/arunvelsriram/hazelcast-kubernetes-example/master/service.yaml
```

Above creates a service named `hazelcast-service` in the `default` namespace. This `service-name` and `namespace` are used in the [hazelcast configuration](src/main/resources/hazelcast.xml#L63) to select those pods that are hazelcast members.

```
kubectl -f https://raw.githubusercontent.com/arunvelsriram/hazelcast-kubernetes-example/master/deployment.yaml
```

Above creates a deployment that creates and manages 3 pods (because replicas is set to 3 in [deployment.yaml](deployment.yaml#L8)). Each pod runs `arunvelsriram/hazelcast-kubernetes-example` docker image. These 3 pods are our hazelcast members.

### 3. Tail the logs

Tail the logs of a pod to see if it has identified other pods as hazelcast members.

```
kubectl logs -f po/hazelcast-deployment-7b657f7c-wc475
```

The logs should contain something like this:

```
...

Members [3] {
	Member [172.17.0.2]:5701 - 93e571d6-2bec-4181-9be9-7ccf6135c127 this
	Member [172.17.0.4]:5701 - 46db1687-3246-465f-98ba-1be1e8facd22
	Member [172.17.0.5]:5701 - f368db9f-a020-440b-b127-f40c76e808f2
}
...
```

This means that everything works and our hazelcast members have identified each other.

### 4. Scale the deployment

Scale the deployment by 5 and tail the logs of a pod.

```
kubectl scale deployment hazelcast-deployment --replicas 5
kubectl logs -f po/hazelcast-deployment-7b657f7c-wc475
```

You should see something like this in the logs:

```
...

Members [5] {
	Member [172.17.0.2]:5701 - 93e571d6-2bec-4181-9be9-7ccf6135c127 this
	Member [172.17.0.4]:5701 - 46db1687-3246-465f-98ba-1be1e8facd22
	Member [172.17.0.5]:5701 - f368db9f-a020-440b-b127-f40c76e808f2
	Member [172.17.0.6]:5701 - a15a8b0a-3049-4c23-b514-07b50874c508
	Member [172.17.0.7]:5701 - 7aab719d-14db-4833-8c37-38f8503c4a11
}

...
```

This means that there are 5 hazelcast members now as intended.

Similarly you can scale down the replicas to see the hazelcast members getting reduced.

## Contributing

```
git clone https://github.com/arunvelsriram/hazelcast-kubernetes-example
cd hazelcast-kubernetes-example
./gradlew clean build
./gradlew start
```
