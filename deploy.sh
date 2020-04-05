docker build -t jstuck/multi-client:latest -t jstuck/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jstuck/multi-server:latest -t jstuck/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jstuck/multi-worker:latest -t jstuck/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jstuck/multi-client:latest
docker push jstuck/multi-server:latest
docker push jstuck/multi-worker:latest

docker push jstuck/multi-client:$SHA
docker push jstuck/multi-server:$SHA
docker push jstuck/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jstuck/multi-server:$SHA
kubectl set image deployments/client-deployment client=jstuck/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jstuck/multi-worker:$SHA