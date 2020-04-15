CURSOR="⟦   ⟧ "
CURSOR_BG=black

cursor() {
  local cursorStatus="%(?.green.red)"
  buildSegment $CURSOR_BG $cursorStatus $CURSOR
}
