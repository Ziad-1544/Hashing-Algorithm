# MIPS Assembly Hashing Algorithm

## Project Overview

This project implements an 8-bit hashing algorithm using MIPS assembly language. The algorithm leverages polynomial transformations and XOR operations to generate hash values efficiently. It is designed to operate within the MARS IDE, ensuring compliance with MIPS conventions and optimal memory usage.

##Features

-Implements an 8-bit hashing algorithm.

-Uses polynomial transformations and XOR operations for hashing.

-Optimized for performance in the MARS IDE.

## Requirements

MARS IDE: Required to run the MIPS assembly code.

Basic understanding of MIPS assembly language.

## Example

```
addi $t0, $zero, 0x45      # Input value
xor $t1, $t0, 0x23         # XOR operation
addi $v0, $t1, 0x12        # Polynomial transformation
```
## Contact

For any questions or issues, feel free to open an issue in the repository or contact me directly.

