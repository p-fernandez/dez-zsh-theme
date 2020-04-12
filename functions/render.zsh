CURRENT_BACKGROUND="NONE"
SEPARATOR=""

buildSegment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BACKGROUND != 'NONE' && $1 != $CURRENT_BACKGROUND ]]; then
    echo -n " %{$bg%F{$CURRENT_BACKGROUND}%}$SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BACKGROUND=$1
  [[ -n $3 ]] && echo -n $3
}

closeSegment() {
  if [[ -n $CURRENT_BACKGROUND ]]; then
    echo -n "%{%k%F{$CURRENT_BACKGROUND}%}$SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BACKGROUND=''
}

compose() {
  for section in $@; do
    if defined "$section"; then
      $section
    else
      "'$section' not found"
    fi
  done
}
