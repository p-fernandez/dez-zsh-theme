# vim:ft=zsh ts=2 sw=2 sts=2

# Battery
BATTERY_GAUGE_FILLED_SYMBOL="▮"
BATTERY_GAUGE_EMPTY_SYMBOL="▯"

# ID
if [ ! -n "${ID_BG+1}" ]; then
  ID_BG=black
fi
if [ ! -n "${ID_FG+1}" ]; then
  ID_FG=white
fi

# NODE
if [ ! -n "${NODE_BG+1}" ]; then
  NODE_BG=green
fi
if [ ! -n "${NODE_FG+1}" ]; then
  NODE_FG=white
fi

# NVM
if [ ! -n "${NVM_BG+1}" ]; then
  NVM_BG=white
fi
if [ ! -n "${NVM_FG+1}" ]; then
  NVM_FG=green
fi
if [ ! -n "${NVM_PREFIX+1}" ]; then
  NVM_PREFIX="⬢ "
fi

# PROMPT
if [ ! -n "${PROMPT_BG+1}" ]; then
  PROMPT_BG=blue
fi
if [ ! -n "${PROMPT_FG+1}" ]; then
  PROMPT_FG=white
fi

# SYSTEM_STATUS
if [ ! -n "${SYSTEM_STATUS_EXIT_SHOW+1}" ]; then
  SYSTEM_STATUS_EXIT_SHOW=false
fi
if [ ! -n "${SYSTEM_STATUS_BG+1}" ]; then
  SYSTEM_STATUS_BG=black
fi
if [ ! -n "${SYSTEM_STATUS_FG+1}" ]; then
  SYSTEM_STATUS_FG=white
fi

# VERSION_CONTROL
if [ ! -n "${VERSION_CONTROL_BG+1}" ]; then
  VERSION_CONTROL_BG=blue
fi
if [ ! -n "${VERSION_CONTROL_FG+1}" ]; then
  VERSION_CONTROL_FG=white
fi

local currentBackground="NONE"
local error="💥"
local gitIcon="'"
local failure=" 💔🗡 "
local me="💀"
local mercuryIcon="☿"
local noVersionControlIcon="○"
local prompt="%~ "
local reset="%{$reset_color%}"
local root=" 🔱 "
local separator=""
local systemJobs="⚙️ "

if [ ! -n "${PROMPT_ORDER+1}" ]; then
  PROMPT_ORDER=(
    #systemStatus
    id
    prompt
    node
    nvm
    versionControl 
  )
fi

buildSegment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $currentBackground != 'NONE' && $1 != $currentBackground ]]; then
    echo -n " %{$bg%F{$currentBackground}%}$separator%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  currentBackground=$1
  [[ -n $3 ]] && echo -n $3
}

closeSegment() {
  if [[ -n $currentBackground ]]; then
    echo -n "%{%k%F{$currentBackground}%}$separator"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  currentBackground=''
}

getVersionFromPackageJson() {
  local version
  # File testing is not working in MacOSx so dirty solution
  version='$(node -pe "function getVersion() { try { return require(\"./package.json\").version } catch(err){ return \"\"; } }; getVersion(); ")'
  echo $version
}

idSegment() {
  local lastActionStatus="%(?..$failure)"
  buildSegment $ID_BG $ID_FG "$(isRoot)${me}${lastActionStatus}"
}

isRoot() {
  local flag=false
  if [[ $UID -eq 0 ]]; then
    echo "$root"
  fi
}

nodeSegment() {
  local version="$(getVersionFromPackageJson)"
  buildSegment $NODE_BG $NODE_FG $version 
}

nvmSegment() {
  local nvmPrompt

  if type nvm >/dev/null 2>&1; then
    nvmPrompt=$(nvm current 2>/dev/null)
    [[ "${nvmPrompt}x" == "x" || "${nvmPrompt}" == "system" ]] && return
  elif type node >/dev/null 2>&1; then
    nvmPrompt=" $(node --version)"
  else
    return
  fi
  nvmPrompt=${NVM_PREFIX}${nvmPrompt}
  buildSegment $NVM_BG $NVM_FG $nvmPrompt
}

promptSegment() {
  buildSegment $PROMPT_BG $PROMPT_FG $prompt
}

# We check if there is an error
# We check if there are bg jobs
systemStatusSegment() {
  local content

  [[ $RETVAL -ne 0 && $SYSTEM_STATUS_EXIT_SHOW != true ]] && content+="$error"
  [[ $RETVAL -ne 0 && $SYSTEM_STATUS_EXIT_SHOW == true ]] && content+="$error $RETVAL"
  [[ $(jobs -l | wc -l) -gt 0 ]] && content+="$systemJobs"

  [[ -n "$content" ]] && buildSegment $SYSTEM_STATUS_BG $SYSTEM_STATUS_FG $content
}

versionControlSegment() {
  local content='$(versionControlIcon) $(git_super_status)'
  buildSegment $VERSION_CONTROL_BG $VERSION_CONTROL_FG $content
}

versionControlIcon() {
  git branch >/dev/null 2>/dev/null && echo "${gitIcon}" && return
  hg root >/dev/null 2>/dev/null && echo "${mercuryIcon}" && return
  echo "${noVersionControlIcon}"
}

buildPrompt() {
  RETVAL=$?
  for feature in $PROMPT_ORDER
  do
    local segment="${feature}Segment"
    ${segment}
    closeSegment
  done
}

PROMPT="%{%f%b%k%}$(buildPrompt) "
RPROMPT="$(battery_level_gauge)"
