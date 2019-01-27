docker build -t oz4899/multi-client:latest -t oz4899/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t oz4899/multi-server:latest -t oz4899/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t oz4899/multi-worker:latest -t oz4899/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push oz4899/multi-client:latest
docker push oz4899/multi-server:latest
docker push oz4899/multi-worker:latest

docker push oz4899/multi-client:$SHA
docker push oz4899/multi-server:$SHA
docker push oz4899/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=oz4899/multi-server:$SHA
kubectl set image deployments/client-deployment server=oz4899/multi-client:$SHA
kubectl set image deployments/worker-deployment server=oz4899/multi-worker:$SHA

