#!/bin/bash
$(/opt/cassandra/bin/cassandra &) && tail -F /opt/cassandra/logs/*.log*

