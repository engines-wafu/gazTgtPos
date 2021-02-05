% Print title and header information
clear;
choice = 0;
pkg load mapping;
addpath("libraries")

printf("+==============================================================+\n");
printf("|       GAZELLE TARGET POSITION COORDINATE CALCULATOR          |\n");
printf("+==============================================================+\n");
printf("|                                                              |\n");
printf("|  Author:  Engines                                            |\n");
printf("|  Version: 0.1                                                |\n");
printf("|  Date:    5 Feb 21                                           |\n");
printf("|                                                              |\n");
printf("|  1.  Select 'PP' on the NADIR then 'GEL' to copy location.   |\n");
printf("|  2.  Select 'BUT' then choose a waypoint to use.             |\n");
printf("|  3.  Press 'ENT' to paste position into selected waypoint.   |\n");
printf("|  4.  Press 'UTM/GEO' and enter the displayed value below.    |\n");
printf("|  5.  Select 'CM/DEC' and enter the bottom displayed value    |\n");
printf("|  below.                                                      |\n");
printf("|  6.  Get the current zone by pressing 'DOWN' on the waypoint |\n");
printf("|  while in the edit mode.                                     |\n");
printf("|  7.  Using NADIR, note bearing and range of target, enter    |\n");
printf("|  this information below.                                     |\n");
printf("|                                                              |\n");
printf("+==============================================================+\n");

function [a, b, dec, zone] = my_position ()
  printf("\n  Current Position\n");
  printf("----------------------------\n");
  a =    input("UTM N:        ");
  b =    input("UTM E:        ");
  zone = input("UTM Zone:     ");
  mgrs = mgrs_fwd(b*10, a*10, zone, 1, 3);
  printf("MGRS:         %s\n", cell2mat(mgrs));
  dec =  input("Declination:  ");
  printf("\n");
endfunction

function [rng, brg] = range_and_bearing ()
  printf("  Target Range and Bearing\n");
  printf("----------------------------\n");
  brg =  input("Bearing:      ");
  rng =  input("Range:        ");
  printf("\n");
endfunction

function print_tartget (a, b, dec, zone, rng, brg)
  printf("  Target Location\n");
  printf("----------------------------\n");
  a_t = a + (rng/10)*(cos(deg2rad(brg-dec)));
  b_t = b + (rng/10)*(sin(deg2rad(brg-dec)));
  printf("Target UTM N: %i\n", roundb(a_t));
  printf("Target UTM E: %i\n", roundb(b_t));
  mgrs = mgrs_fwd(b_t*10, a_t*10, zone, 1, 3);
  printf("MGRS:         %s\n", cell2mat(mgrs));
##  ll = utm2ll(b_t*10, a_t*10, zone);
##  latdeg = degrees2dms(ll)(2,1);
##  latmin = degrees2dms(ll)(2,2);
##  latsec = degrees2dms(ll)(2,3);
##  longdeg = degrees2dms(ll)(1,1);
##  longmin = degrees2dms(ll)(1,2);
##  longsec = degrees2dms(ll)(1,3);
##  printf("Target Lon:   N%d %d.%i\n", longdeg, longmin, roundb(longsec));
##  printf("Target Lat:   E%d %d.%i\n", latdeg, latmin, roundb(latsec));
endfunction

function [choice] = user_choose
  choice = input("\nNew target from same location [1], new location [2], or quit [C-c]? ");
  printf("\n");
endfunction

while (choice != 1 || choice != 2)
  if (choice == 2 || choice == 0);
    [a, b, dec, zone] = my_position;
    [rng, brg] = range_and_bearing;
    print_tartget(a, b, dec, zone, rng, brg);
    choice = user_choose;
  elseif choice == 1;
    [rng, brg] = range_and_bearing;
    print_tartget(a, b, dec, zone, rng, brg);
    choice = user_choose;
  else
    choice = user_choose;
  endif
endwhile
