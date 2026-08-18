  ! nteach_filepath.inc
  !
  !  Filepath and nteach occasionally depend on the run, so put them here so main part
  !    of globals just has one common file for all runs

  ! nteach depends on estimation vs validation sample
   !estimation:
  integer, parameter :: validation = 0
  integer, parameter :: nteach = 6600 

  !validation:
  !integer, parameter :: validation = 1
  !integer, parameter :: nteach = 6741 

   

  ! filepath varies by structure of replication folder
  character(len=30), parameter :: filepath = '../../../..'
