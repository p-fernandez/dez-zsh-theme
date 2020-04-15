SEPARATOR="|"

buildSegment() {
  local content
  [[ -n $1 ]] && content="$1" || content=""
  echo -n $content
}

closeSegment() {
  echo -n ""
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
