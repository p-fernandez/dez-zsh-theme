NODE_SYSTEM_BG=yellow
NODE_SYSTEM_FG=white
NODE_SYSTEM_ICON=""

nodeSystemVersion() {
  local nodeSystemVersion

  if type nvm >/dev/null 2>&1; then
    nodeSystemVersion=$(nvm current 2>/dev/null)
    [[ "${nodeSystemVersion}x" == "x" || "${nodeSystemVersion}" == "system" ]] && return
  elif type node >/dev/null 2>&1; then
    nodeSystemVersion=" $(node --version)"
  else
    return
  fi

  buildSegment $NODE_SYSTEM_BG $NODE_SYSTEM_FG "$NODE_SYSTEM_ICON $nodeSystemVersion"
}
