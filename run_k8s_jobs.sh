#!/bin/bash

CONC=20

kubectl apply -f configs.yaml
kubectl apply -f jobs.yaml

kubectl patch job fio-s3-writes -p "{\"spec\":{\"parallelism\":20}}"
kubectl wait --for=condition=complete --timeout=1800s job.batch/fio-s3-writes
sleep 5  # Insert some time between phases for clearer metrics.

kubectl patch job fio-s3-reads -p '{"spec":{"parallelism":20}}'
kubectl wait --for=condition=complete --timeout=1800s job.batch/fio-s3-reads
sleep 5

kubectl patch job fio-s3-trims -p '{"spec":{"parallelism":20}}'
kubectl wait --for=condition=complete --timeout=1800s job.batch/fio-s3-trims
sleep 5

kubectl delete -f jobs.yaml
kubectl delete -f configs.yaml
