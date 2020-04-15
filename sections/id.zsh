FAILURE="💔🗡 "
ME="💀 ₱₣"
SUPER_USER="🔱"

ID_BG=232
ID_FG=56

isRoot() {
  if [[ $UID -eq 0 ]]; then
    echo $SUPER_USER
  fi
}

id() {
  local id="$ME"
  local isRoot=$(isRoot)
  local lastActionStatus=%(?..$FAILURE)

  if (( ${+isRoot} )); then
    id="$isRoot $id"
  fi

  if (( ${+lastActionStatus} )); then
    id="$id ${lastActionStatus}"
  fi

  local f=$ID_FG
  local b=$ID_BG
  local result
  for (( i=0; i<${#id}; i++ )); do
    ((f--))
    ((b++))
    result+=$(colorAndStyle ${id:$i:1} $f $b) 
  done

  buildSegment $result
}
