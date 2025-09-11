# Task 2: Debugging Challenge - Solving with GDB Scripting

## Overview
This challenge is part of my ongoing journey through pwn.college, where I focus on solving the hardest and most intriguing tasks. Task 2 required analyzing and debugging a program using advanced GDB scripting techniques to extract and manipulate runtime information.

## Objectives
1. **Analyze the Program**: Understand the program's behavior and identify the critical points for debugging.
2. **Automate with GDB**: Use GDB scripting to automate the debugging process and extract key runtime information.
3. **Solve the Challenge**: Leverage the insights gained from GDB to solve the challenge efficiently.

## Solution Highlights
To solve this challenge, I wrote a custom GDB script (`t.gdb`) that automates the debugging process. The script performs the following steps:

1. **Set Breakpoints**:
   - A breakpoint is set at a specific line in the source code (`ioputs.c:33`) to pause execution at the critical point.

2. **Extract Runtime Information**:
   - The script reads a local variable from the stack (`$rsp + 0x30`) and prints its value in hexadecimal format.

3. **Automate Execution**:
   - The script uses GDB's `commands` feature to automate the process of extracting the variable's value and continuing execution.

4. **Output Insights**:
   - The script outputs the current value of the variable at each breakpoint, providing valuable insights into the program's behavior.

### GDB Script (`t.gdb`)
```plaintext
start
break ioputs.c:33
commands
  set $local_variable = *(unsigned long long*)($rsp+0x30)
  printf "Current value: %llx\n", $local_variable
  continue
end
continue