PACKAGE_VERSION_ICON=""

PACKAGE_VERSION_BG=black
PACKAGE_VERSION_FG=brown

packageVersion() {
  local packageVersion

  if [[ -f package.json ]]; then
    packageVersion=$(node -p "require('./package.json').version" 2> /dev/null)
  fi

  [[ -z $packageVersion || "$packageVersion" == "null" || "$packageVersion" == "undefined" ]] && return

  buildSegment $PACKAGE_VERSION_BG $PACKAGE_VERSION_FG "$PACKAGE_VERSION_ICON $packageVersion" 
}
