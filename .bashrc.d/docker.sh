function docker-ssh {
  ssh root@`sudo docker inspect $1 | egrep IPA | sed 's/[^0-9.]//g'`
}

function docker-srm {
  sudo docker stop $1 && sudo docker rm $1
}
