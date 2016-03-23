function cb() {
  HOST=`hostname`
  if [[ $HOST = 'duffy.local' ]]
  then
    pbcopy
  else
    ssh 192.168.77.1 pbcopy
  fi
}
