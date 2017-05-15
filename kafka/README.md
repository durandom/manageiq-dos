# Kafka for use with ManageIQ

1. start your minishift cluster as in ../minishift
2. run `./up.sh`

## Access broker from localhost

```bash
# get the pod name
KAFKA_POD=$(oc get pods -l app=apache-kafka -o custom-columns=NAME:.metadata.name | tail -n 1)
echo $KAFKA_POD

# create a topic
oc rsh $KAFKA_POD bin/kafka-topics.sh --create --zookeeper apache-kafka --replication-factor 1 --partitions 1 --topic funky

# list topics
oc rsh $KAFKA_POD bin/kafka-topics.sh --list --zookeeper apache-kafka

# write to topic
echo "schwifty" | oc rsh $KAFKA_POD bin/kafka-console-producer.sh --broker-list apache-kafka:9092 --topic funky

# read from topic
oc rsh $KAFKA_POD bin/kafka-console-consumer.sh --bootstrap-server apache-kafka:9092 --topic funky --from-beginning

# lookup nodePort from ingress service
oc export svc apache-kafka-ingress
# ...
#   ports:
#   - name: port-1
#     nodePort: 31956
#     port: 9092
#     protocol: TCP
#     targetPort: 9092
kafkacat -L -b $(minishift ip):31956
```

## Gotchas

You might need to add `127.0.0.1 localhost apache-kafka` to `/etc/hosts` because the kafka broker announces it's name

## Links and Credits

* https://github.com/mattf/openshift-kafka
* https://gitlab.com/goern/oe2k
* https://github.com/edenhill/kafkacat

