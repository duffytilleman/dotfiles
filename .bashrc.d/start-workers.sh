start-workers () {
  for worker in $@; do
    sudo systemctl enable $worker@1
    sudo systemctl start $worker@1
  done
}
