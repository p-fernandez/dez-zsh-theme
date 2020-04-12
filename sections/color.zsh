color() {
  local bg="$BG[004]"
  local fg="$FG[154]"
  local fx="$FX[reverse]"
  local reset="%{$reset_color%}"
  local text="TEST"
  echo -n "$fx$bg$fg$text$reset"
  # spectrum_ls
  # spectrum_bls
  # echo ${(kv)FG}
  # echo ${(kv)FX}
}
