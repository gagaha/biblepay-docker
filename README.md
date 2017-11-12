# biblepay-docker
 Docker Container for Biblepay

Based on Ubuntu 16.04, this container will run biblepayd. Contains also the biblepay-cli and all necessary dependencies and libraries. For configuration, either link the volume to a local path and edit biblepay.conf or pass environment variables and they will be replaced/added in the biblepay.conf.


## Links

-	[`GitHub` (*gagaha/biblepay-docker*)](https://github.com/gagaha/biblepay-docker)
-	[`Docker Hub` (*gagaha/biblepay*)](https://hub.docker.com/r/gagaha/biblepay/)


# Usage:

## Run container
```
docker run -d --name biblepay \
-v $(pwd)/biblepay-data:/root/.biblepaycore gagaha/biblepay
```

## Run with environment variables
```
docker run -d --name biblepay \
-v $(pwd)/biblepay-data:/root/.biblepaycore \
-e "REINDEX=1" -e "GEN=1" -e "POOLPORT=80" \
-e "POOL=http://pool.biblepay.org" -e "WORKERID=gaga-worker2" \
-e "GENPROCLIMIT=2" gagaha/biblepay
```

## Supported environment variables:
- REINDEX: reindex blocks (1/0 for true/false)
- GEN: generate - start mining (1/0 for true/false)
- POOLPORT: port number of the pool
- POOL: url of the pool
- WORKERID: worker id/name on the pool
- GENPROCLIMIT: number of concurrent mining processes 
- ADDNODE: node address (set by default: 'node.biblepay.org', 'biblepay.inspect.network')


## biblepay-cli example:

```
docker exec biblepay biblepay-cli getmininginfo
```
