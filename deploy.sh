docker build -t eefth/multi-client:latest -t eefth/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t eefth/multi-server:latest -t eefth/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t eefth/multi-worker:latest -t eefth/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push eefth/multi-client:latest
docker push eefth/multi-server:latest
docker push eefth/multi-worker:latest

docker push eefth/multi-client:$SHA
docker push eefth/multi-server:$SHA
docker push eefth/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=eefth/multi-server:$SHA
kubectl set image deployments/client-deployment client=eefth/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=eefth/multi-worker:$SHA
