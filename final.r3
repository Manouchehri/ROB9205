sub painting() ;; This is used for the painting process
  output_set(14, 1) ;; Turn on cylinder
  delay(500) ;; Delay for 500 milliseconds
  output_set(14, 0) ;; Turn off cylinder
  delay(500)
  output_set(14, 1)
  delay(500)
  output_set(14, 0)
  delay(500)
  output_set(14, 1)
  delay(500)
  output_set(14, 0)
end sub

sub liftbit() ;; This process is used to gently lift a piece
  grip(3) ;; Ensure that the grippers are open
  grip_finish()
  tz(40) ;; Go down (not used in courseware, command #1)
  finish()
  grip(2.25) ;; Clamp down
  grip_finish()
  tz(-40) ;; Lift up
  finish()
end sub

sub pieceremoveal(int n)
  case n ;; Not used in courseware, command #2
    of 1:
      move(abovelocation1)
      liftbit()
      move(droparea)
      grip(3)
    of 2:
      move(abovelocation2)
      liftbit()
      move(droparea)
      grip(3)
    of 3:
      move(abovelocation3)
      liftbit()
      move(droparea)
      grip(3)
  end case      
end sub

main
teachable cloc abovelocation1, abovelocation2, abovelocation3, droparea
speed 25
startinghere::
if(input(6)) ;; safety switch
  ready()
  grip(3)
  finish()
  output_set(13, 1) ;; this is the converyor, turn it on
    if(input(1)) ;; light sensor 1
    output_set(13, 0) ;; turn off belt
    painting()
    move(abovelocation1) 
    liftbit()
    output_set(13, 1)
    move(abovelocation3)
    sensorspot::
      if(input(1)) ;; This is the light sensor
        output_set(13, 0)
        tz(40)
        finish()
        grip(3) ;; drop the piece
        tz(-40)
        goto startinghere
    end if
    goto sensorspot
  end if
end if

if(input(2) || input(3) || input(4)) ;;If any of the remove buttons area pressed (OR operator not used in courseware, command #3)
  if(2)
    pieceremoveal(1) ;;Variable passing not used in courseware, command #4
  end if
    
  if
    pieceremoveal(2)
  end if

  if
    pieceremoveal(3)
  end if  
end if

goto startinghere
end main
