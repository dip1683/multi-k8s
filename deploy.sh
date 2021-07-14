docker build -t dip1683/multi-client:latest -t dip1683/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dip1683/multi-server:latest -t dip1683/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t dip1683/multi-worker:latest -t dip1683/multi-worker:$SHA -f ./worker/Dockerfile ./worker 

docker push dip1683/multi-client:latest 
docker push dip1683/multi-server:latest 
docker push dip1683/multi-worker:latest 

docker push dip1683/multi-client:$SHA 
docker push dip1683/multi-server:$SHA 
docker push dip1683/multi-worker:$SHA 

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dip1683/multi-server:$SHA 
kubectl set image deployments/client-deployment client=dip1683/multi-client:$SHA 
kubectl set image deployments/worker-deployment worker=dip1683/multi-worker:$SHA 

