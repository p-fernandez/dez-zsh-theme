bgStyle() {
  echo -n "\e[48;5;${1}m"
}

fgStyle() {
  echo -n "\e[38;5;${1}m"
}

reset() {
  echo -n "\e[0m"
}

buildStyle() {
  fgStyle $2
  bgStyle $3
  echo -n $1
  reset
}

colorAndStyle() {
  local frontColor
  local backColor
  local style
  local text=$1
  [[ -n $2 ]] && frontColor="$2" || frontColor=122
  [[ -n $3 ]] && backColor="$3" || backColor=38
  buildStyle $text $frontColor $backColor
}
