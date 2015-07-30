time-update() {
  sudo sh -c "service ntp stop && ntpd -gq && service ntp start"
}
