# vim:ft=zsh ts=2 sw=2 sts=2

NEWLINE='
'

if [[ -z "$BASE_PATH" ]]; then
    # Get the path to file this code is executing in; then
    # get the absolute path and strip the filename.
    # See https://stackoverflow.com/a/28336473/108857
    export BASE_PATH=${${(%):-%x}:A:h}
fi

if [ -z "$PROMPT_ORDER" ]; then
  PROMPT_ORDER=(
    #color
    #nodeSystemVersion
    #requiredNodeVersion
    #packageVersion
    #versionControl
    id
    #cursor
  )
fi

if [ -z "$RPROMPT_ORDER" ]; then
  RPROMPT_ORDER=(
  )
fi

source "$BASE_PATH/functions/color.zsh"
source "$BASE_PATH/functions/render.zsh"
source "$BASE_PATH/functions/shell.zsh"

for section in $(union $PROMPT_ORDER $RPROMPT_ORDER); do
  if [[ -f "$BASE_PATH/sections/$section.zsh" ]]; then
    source "$BASE_PATH/sections/$section.zsh"
  else
    echo "Section '$section' have not been loaded."
  fi
done

prompt() {
  RETVAL=$?

  echo -n $NEWLINE
  compose $PROMPT_ORDER
}

rprompt() {
  RETVAL=$?

  echo $NEWLINE
  compose $RPROMPT_ORDER
}

setup() {
  PROMPT='$(prompt)'
  RPROMPT='$(rprompt)'
}

setup "$@"
