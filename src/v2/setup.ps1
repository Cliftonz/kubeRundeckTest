echo -n 'masterpassword123.' > ./masterpassword
kubectl create secret generic rundeckpro-storage-converter --from-file=./masterpassword

echo -n 'minio' > ./awskey
echo -n 'minio123' > ./awssecret
kubectl create secret generic rundeckpro-log-storage --from-file=./awskey --from-file=./awssecret

echo -n 'rundeck123.' > ./password
kubectl create secret generic mysql-rundeckuser --from-file=./password

kubectl create secret generic rundeckpro-license --from-file=./data/rundeckpro-license.key

kubectl create secret generic rundeckpro-admin-acl --from-file=./data/admin-role.aclpolicy

kubectl apply -f persistent-volumes.yaml
kubectl apply -f minio-deployment.yaml
kubectl apply -f mysql-deployment.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=90s

kubectl apply -f rundeckpro-deployment.yaml

kubectl port-forward service/rundeckpro 8080:8080
