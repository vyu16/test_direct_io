program test

  implicit none

  character(*), parameter :: fname = 'abcde.dat'
  integer, parameter :: nn = 1194393600
  integer, parameter :: long = selected_int_kind(18)
  integer, parameter :: dp = selected_real_kind(14,200)

  integer :: ierr
  integer :: iunit
  integer(long) :: reclen
  complex(dp) :: dummy(nn)

  dummy = 0
  ierr = 0

  print *,'record length should be:',16_long*nn

  inquire(iolength=reclen) dummy
  print *,'record length returned by inquire:',reclen

  open(newunit=iunit,file=fname,iostat=ierr,form='unformatted',access='direct',recl=reclen)
  if(ierr /= 0) print *,'cannot open, error:',ierr

  inquire(iunit,recl=reclen)
  print *,'record length in file:',reclen

  write(iunit,rec=1,iostat=ierr) dummy
  if(ierr /= 0) print *,'cannot write, error:',ierr

  close(iunit,iostat=ierr)
  if(ierr /= 0) print *,'cannot close, error:',ierr

end program
