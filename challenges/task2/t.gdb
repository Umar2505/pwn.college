start
break ioputs.c:33
commands
  set $local_variable = *(unsigned long long*)($rsp+0x30)
  printf "Current value: %llx\n", $local_variable
  continue
end
continue