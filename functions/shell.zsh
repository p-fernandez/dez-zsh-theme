defined() {
  typeset -f + "$1" &> /dev/null
}

union() {
  typeset -U sections=("$@")
  echo $sections
}

