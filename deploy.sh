docker build -t sstathatos/multi-client:latest -t sstathatos/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sstathatos/multi-server:latest -t sstathatos/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sstathatos/multi-worker:latest -t sstathatos/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sstathatos/multi-client:latest
docker push sstathatos/multi-client:$SHA
docker push sstathatos/multi-server:latest
docker push sstathatos/multi-server:$SHA
docker push sstathatos/multi-worker:latest
docker push sstathatos/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sstathatos/multi-server:$SHA
kubectl set image deployments/client-deployment client=sstathatos/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sstathatos/multi-worker:$SHA
