# moby-api-ui
Repository for containerized swagger UI of Moby (Docker) API

Latest version loads latest swagger.yaml from Moby GitHub repository on container start.

## How to run
Exposed ports:
 - 8080 on which nginx is running

Variables:
- API_URL :  host and port of server. By default _localhost:8080_


For correct work you need to add _docker.sock_ as volume

`docker run -p 8888:8080 -e API_URL="localhost:8888" -v /var/run/docker.sock:/var/run/docker.sock kastsialei/docker-api-ui`

It's possible also use Moby (Docker) api by simple calling using curl or even Postman. Nginx proxy pass all requests to /docker/ location to _docker.sock_:

 `curl -X GET "http://localhost:8888/docker/containers/json" -H  "accept: application/json"`
