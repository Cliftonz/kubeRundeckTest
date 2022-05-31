kubectl delete deployment,service rundeckpro
kubectl delete ingress rudeckpro-nginx
kubectl delete deployment,service mysql
kubectl delete deployment,service minio
kubectl delete job minio-create-bucket

# secrets and volumes are not destroyed