# fio-s3-benchmarking
Ansible and Kubernetes for benchmarking S3 with fio

Dockerfile builds fio from source with the necessary libraries to support s3.

## Ansible instructions:

* Update s3credentials.yaml with access and secret key. Do not check this in!
* Update hosts, s3endpoint, and s3bucket info the vars section of playbook.yaml.
* Run playbook to 1) write objects, 2) read objects, and then 3) delete objects.

## Kubernetes instructions:

The Kubernetes benchmark is a set of three jobs that can be run in sequence, as well as a ConfigMap to store the fio job config.

See "run_k8s_jobs.sh" for an example of how to run the write/read/delete stages sequentially. This approach works by creating all jobs initially with 0 parallelism, i.e., idle. Then, increases the parallelism of each job one a time and waits for completion before moving on to the next.

To configure test parameters, edit the Configmap in jobs.yaml. Access/secret keys for S3 are found in a Kubernetes secret named 'my-s3-keys.'

To create the necessary secret for S3 access keys:
```
kubectl create secret generic my-s3-keys --from-literal=access-key='XXXXXXX' --from-literal=secret-key='YYYYYYY'
```
