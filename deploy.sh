docker build -t melkfett/multi-client-k8s:latest -t melkfett/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t melkfett/multi-server-k8s-pgfix:latest -t melkfett/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t melkfett/multi-worker-k8s:latest -t melkfett/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push melkfett/multi-client-k8s:latest
docker push melkfett/multi-server-k8s-pgfix:latest
docker push melkfett/multi-worker-k8s:latest

docker push melkfett/multi-client-k8s:$SHA
docker push melkfett/multi-server-k8s-pgfix:$SHA
docker push melkfett/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=melkfett/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=melkfett/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=melkfett/multi-worker-k8s:$SHA