It appears that nvfortran cannot handle Fortran direct access I/O when the record length is bigger than the maximum value of a 32-bit integer.

How to reproduce:

```
$ gfortran --version

GNU Fortran (GCC) 11.2.0 20210728 (Cray Inc.)
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

$ gfortran -o test.x test.f90 

$ ./test.x 

  record length should be:          19110297600
  record length returned by inquire:          19110297600
  record length in file:          19110297600
```

```
$ nvfortran --version

nvfortran 21.7-0 64-bit target on x86-64 Linux -tp zen 
NVIDIA Compilers and Tools
Copyright (c) 2021, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.

$ nvfortran -o test.x test.f90

$ ./test.x 

  record length should be:              19110297600
  record length returned by inquire:                        3
  record length in file:                        3
  cannot write, error:          219
```
