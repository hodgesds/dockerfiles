.PHONY: clean
clean:
	docker rmi cassandra kafka elasticsearch

.PHONY: cassandra
cassandra:
	docker build --tag cassandra -f ./cassandra/cassandra.dockerfile ./cassandra

.PHONY: kafka
kafka:
	docker build --tag kafka -f ./kafka/kafka.dockerfile ./kafka

.PHONY: elasticsearch
elasticsearch:
	docker build --tag elasticsearch -f ./elasticsearch/elasticsearch.dockerfile ./elasticsearch
