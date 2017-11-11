# biblepay-docker
 Docker Container for Biblepay

Based on Ubuntu 16.04, this container will run biblepayd. Contains also the biblepay-cli and all necessary dependencies and libraries. I recommend linking a volume in order to modify the biblepay.conf and to store your wallet.

## Dockerfile

-	[`linux` (*biblepay-docker/Dockerfile*)](https://github.com/gagaha/biblepay-docker/Dockerfile)


# Usage:

## Run container
```console
$ docker run -d --name biblepay \
-v $(pwd)/biblepay-data:/root/.biblepaycore gagaha/biblepay
```

## Run with environment variables
```console
docker run -d --name biblepay \
-v $(pwd)/biblepay-data:/root/.biblepaycore \
-e "REINDEX=1" -e "GEN=1" -e "POOLPORT=80" \
-e "POOL=http://pool.biblepay.org" -e "WORKERID=gaga-worker2" \
-e "GENPROCLIMIT=2" gagaha/biblepay
```

## biblepay-cli example:

```console
$ docker exec biblepay biblepay-cli getmininginfo
```
