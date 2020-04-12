FAILURE="💔🗡 "
ME="💀"
SUPER_USER="🔱"

ID_BG=black
ID_FG=white

isRoot() {
  if [[ $UID -eq 0 ]]; then
    echo $SUPER_USER
  fi
}

id() {
  local lastActionStatus="%(?..$FAILURE)"
  buildSegment $ID_BG $ID_FG "$(isRoot) $ME $lastActionStatus"
}
