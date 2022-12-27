function cd 
  builtin cd "$argv"
  set RET $status
  ls 
  return $RET
end
