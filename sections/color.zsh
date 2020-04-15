
round() {
  local precision=$1
  local value=$2
  local rounded=$(printf "%.*f\n" $precision $value)
  echo $rounded
}

rgbToAnsi() {
  local r=$1
  local g=$2
  local b=$3
  if [[ $r == $g ]] && [[ $g == $b ]]; then 
    if $r < 8; then
      echo 16
    elseif $r > 248
    else
      local diff=$r-8
      diff=$diff*24/247
      round 0 $diff+232;
    fi
  fi

  const rR=$(round 0 $r*5/255)
  const rG=$(round 0 $g*5/255)
  const rB=$(round 0 $b*5/255)
  local ansi=16+36*$rR+6*rG+$rB
  echo $ansi
}

rgbToAnsi2() {
  local cR=$1
  local cG=$2
  local cB=$3
  local text=$4
  echo "\x1b[38;5;122m${text}\x1b[0m\n"
  echo "\x1b[38;2;$cR;$cG;${cB}m${text}\x1b[0m\n"
}

color() {
  # 232-255 black to white
  local bg="$BG[004]"
  local fg="$FG[154]"
  local fx="$FX[reverse]"
  local reset="%{$reset_color%}"
  local text="TEST"
  rgbToAnsi2 255 255 0 "TRUECOLOR" 
  echo -n "$fx$bg$fg$text$reset"
  # spectrum_ls
  # spectrum_bls
  # echo ${(kv)FG}
  # echo ${(kv)FX}
}
