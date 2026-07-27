module timer
  use global_variables

  real :: t1, t2, rate
  integer :: cr, cm, clock1, clock2



contains

  subroutine initialize_timer()
    !using cpu timer
    call cpu_time(t1)


    !! First initialize the system_clock
    !CALL system_clock(count_rate=cr)
    !CALL system_clock(count_max=cm)
    !rate = REAL(cr)
    !if (mpi_id ==0) WRITE(*,*) "system_clock rate ",rate
    !
    !CALL SYSTEM_CLOCK(clock1)
    
    

  end subroutine initialize_timer

  subroutine time_stamp(num)
    integer, intent(in) :: num
    !cpu timer
    call cpu_time(t2)
    
    if (mpi_id ==0) print*, t2-t1, num


    !! system clock timer
    !CALL SYSTEM_CLOCK(clock2)
    !
    !if (mpi_id ==0) print*, (clock2 - clock1)/rate, num

  end subroutine time_stamp

end module timer
