GIT_ICON=""
VERSION_CONTROL_BG=blue
VERSION_CONTROL_FG=white

versionControl() {
  local content="$(versionControlIcon) $(git_super_status)"
  buildSegment $VERSION_CONTROL_BG $VERSION_CONTROL_FG $content
}

versionControlIcon() {
  git branch >/dev/null 2>/dev/null && echo "${GIT_ICON}" && return
  echo "$noVersionControlIcon"
}
