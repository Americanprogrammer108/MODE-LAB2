       identification division.
       program-id. T2-01-P2.
       author. your name here.
       date-written. date.
      *Program Description:
      *
       environment division.
       input-output section.
       file-control.
      *
           select teacher-file
               assign to "../../../T2-01-P2.dat"
               organization is line sequential.
      *
           select print-file
               assign to "../../../T2-01-P2.out"
               organization is line sequential.
      *
       data division.
       file section.
      *
       fd teacher-file
           data record is teacher-rec
           record contains 26 characters.
      *
       01 teacher-rec.
         05 in-name pic x(20).
         05 in-salary pic 9(5).
         05 in-performance pic x.
           88 G-performance value "G".
           88 S-performance value "S".
           88 A-performance value "A".
      *
       fd print-file
           data record is print-line
           record contains 132 characters.

       01 print-line pic x(132).
      *
       working-storage section.
      *
       01 ws-eof-flag pic x value "n".
      *
       01 ws-detail-output.
         05 filler pic x(5).
         05 ws-prt-name pic x(20).
         05 filler pic x(5).
         05 ws-rt-old-salary pic zz,zz9.
         05 filler pic x(5).
         05 ws-prt-calc-raise pic zz,zz9.
         05 filler pic x(5).
         05 ws-prt-actual-raise pic zz,zz9.
         05 filler pic x(6).
         05 ws-prt-new-salary pic zz,zz9.
         05 filler pic x(4).
         05 ws-prt-comment pic x(30).
         05 filler pic x(28).
      *
       01 ws-heading1.
         05 filler pic x(8) value '    NAME'.
         05 filler pic x(23) value spaces.
         05 filler pic x(3) value 'OLD'.
         05 filler pic x(5) value spaces.
         05 filler pic x(10) value 'CALCULATED'.
         05 filler pic x(4) value spaces.
         05 filler pic x(6) value 'ACTUAL'.
         05 filler pic x(5) value spaces.
         05 filler pic x(3) value 'NEW'.
      *
       01 ws-heading2.
         05 filler pic x(30) value spaces.
         05 filler pic x(6) value 'SALARY'.
         05 filler pic x(5) value spaces.
         05 filler pic x(6) value 'RAISE'.
         05 filler pic x(6) value spaces.
         05 filler pic x(6) value 'RAISE'.
         05 filler pic x(4) value spaces.
         05 filler pic x(6) value 'SALARY'.

       01 ws-total-line.
         05 filler pic x(18) value spaces.
         05 filler pic x(30) value "         Total raise amount = ".
      *               ----+----1----+----2----+----3
         05 ws-tl-total-raise pic $$,$$$,$$9.
         05 filler pic x(84) value spaces.
      *
       01 ws-total-adj-line.
         05 filler pic x(18) value spaces.
         05 filler pic x(30) value "Total adjusted raise amount = ".
      *               ----+----1----+----2----+----3
         05 ws-tl-total-adj-raise pic $$,$$$,$$9.
         05 filler pic x(84) value spaces.
      *
       01 ws-calculatedraise pic 99999v99.
       01 ws-actualraise pic 99999v99.
       01 ws-newsalary pic 99999v99.

       01 ws-total1 pic 99999v99.
       01 ws-total2 pic 99999v99.
       01 ws-total3 pic 99999v99.
       01 ws-total4 pic 99999v99.
       01 ws-total5 pic 99999v99.

       01 ws-maxlimit pic 99999v99 value 70000.

       01 ws-totalcalculatedraise pic 99999v99.
       01 ws-totalactualraise pic 99999v99.

       01 ws-getactualraise pic 99999v99.
       01 ws-getcalculatedraise pic 99999v99.
       procedure division.
       000-main.
      *
           open input teacher-file,
             output print-file.
      *
           write print-line from ws-heading1 after advancing 1 line.
           write print-line from ws-heading2 after advancing 1 line.
      *
           read teacher-file
               at end
                   move "y" to ws-eof-flag.
      *
           perform 100-process-logic until ws-eof-flag = "y"
      *
           move ws-totalcalculatedraise to ws-tl-total-adj-raise.
           move ws-totalactualraise to ws-tl-total-raise.
           write print-line from ws-total-line after advancing 2 lines.
           write print-line from ws-total-adj-line after advancing 2
             lines.
      *
           close teacher-file, print-file.
      *
           display "Print finished.".
           accept return-code.
           stop run.
      *
       100-process-logic.
      *  main logic paragraph - add main loop logic here
      *
           move in-name to ws-prt-name.
           move in-salary to ws-rt-old-salary.
           perform 150-calculatedraise.
      *    perform 200-actualraise.
      *
           write print-line from ws-detail-output after advancing 2
             lines.
      *
           read teacher-file
               at end
                   move "y" to ws-eof-flag.


       150-calculatedraise.
           multiply 0.035 by in-salary
             giving ws-calculatedraise.
      *0.035 * salary
      *example, 70,000 * 0.035 = 2,450    
      *    2,450 + 70,000 = 72,450
           add ws-calculatedraise to in-salary
             giving ws-total1.

      *72,450 * 0.016 = 1,159.2 + 2,450 = 3,609.2 => 3,609
      *this can be done by calling the function below
           perform 200-actualraise.
           
           perform 250-newsalary.
           perform 300-calculatetotalcalculatedraise.
           perform 400-calculatetotalactualraise.
      ******************************************************************
       200-actualraise.
           if G-performance then
               if in-salary >= ws-maxlimit then
                   move 0 to ws-prt-actual-raise
                   multiply 0.016 by ws-total1
                     giving ws-actualraise, ws-total4
                   add ws-calculatedraise to ws-actualraise
                     giving ws-total2
      *                display ws-total2
                   move ws-total2 to ws-prt-calc-raise
                   move ws-total2 to ws-prt-actual-raise

               else
      *72,450 * 0.016
                   multiply 0.016 by ws-total1
                     giving ws-actualraise, ws-total4
                   add ws-calculatedraise to ws-actualraise
                     giving ws-total2
      *                display ws-total2
                   move ws-total2 to ws-prt-calc-raise
                   move ws-total2 to ws-prt-actual-raise
               end-if

           end-if.

           if S-performance then
               if in-salary >= ws-maxlimit then
                   move 0 to ws-prt-actual-raise
                   multiply 0.032 by ws-total1
                     giving ws-actualraise rounded
                   add ws-calculatedraise to ws-actualraise
                     giving ws-total2
                   move ws-total2 to ws-prt-calc-raise
                   move ws-total2 to ws-prt-actual-raise
               else
                   multiply 0.032 by ws-total1
                     giving ws-actualraise rounded
                   add ws-calculatedraise to ws-actualraise
                     giving ws-total2
                   move ws-total2 to ws-prt-calc-raise
                   move ws-total2 to ws-prt-actual-raise
               end-if
           end-if.

           

       250-newsalary.
           move 0 to ws-total3.
           if A-performance then
      *        display "Calculated raise " ws-calculatedraise
               add ws-calculatedraise to in-salary
                 giving ws-total3
               if ws-total3 >= ws-maxlimit then
                   move ws-maxlimit to ws-prt-new-salary
                   subtract ws-maxlimit from in-salary
                     giving ws-prt-actual-raise
                   move "SALARY ADJUSTED" to ws-prt-comment
               else
                   move " " to ws-prt-comment
                   move ws-total3 to ws-prt-new-salary
               end-if
               move ws-calculatedraise to ws-prt-actual-raise
               move ws-calculatedraise to ws-prt-calc-raise
           else
               add in-salary to ws-total2
                 giving ws-total3
               if ws-total3 is >= ws-maxlimit then
                   move ws-maxlimit to ws-prt-new-salary
                   subtract ws-maxlimit from in-salary
                   giving ws-prt-actual-raise
                   move "SALARY ADJUSTED" to ws-prt-comment
               else
                   move ws-total3 to ws-prt-new-salary
                   move " " to ws-prt-comment
               end-if
           end-if.
           



       300-calculatetotalcalculatedraise.
           move ws-prt-actual-raise to ws-getcalculatedraise.
           add ws-getcalculatedraise to ws-totalcalculatedraise.
           
       400-calculatetotalactualraise.
           move ws-prt-calc-raise to ws-getactualraise.
           add ws-getactualraise to ws-totalactualraise.
      *
      ******************************************************************
       end program T2-01-P2.