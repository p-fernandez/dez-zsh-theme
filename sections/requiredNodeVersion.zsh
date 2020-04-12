NODE_ICON=" "

NODE_BG=green
NODE_FG=white

requiredNodeVersion() {
  local requiredNodeVersion

  if [[ -f package.json ]]; then
    requiredNodeVersion=$(node -p "require('./package.json').engines.node" 2> /dev/null)
  fi

  [[ -z $requiredNodeVersion || "$requiredNodeVersion" == "null" || "$requiredNodeVersion" == "undefined" ]] && return

  buildSegment $NODE_BG $NODE_FG "$NODE_ICON $requiredNodeVersion" 
}
