       identification division.
       program-id. T2-02-P1.
       author. yournamehere.
       date-written. date.
      *Program Description:
      *
       environment division.
       input-output section.
       file-control.
           select in-file
           	   assign "../../../T2-01-P1.dat"
               organization is line sequential.
      *
           select print-file
               assign "../../../T2-01-P1.out"
               organization is line sequential.
      *
       data division.
       file section.
       fd in-file
           data record is in-rec
           record contains 20 characters.
      *
       01 in-rec.
         05 in-number pic xxx.
         05 in-name pic x(10).
         05 in-shift-code pic x.
           88 is-day value "D".
           88 is-night value "N".
         05 in-job-class pic x.
           88 is-1 value "1".
           88 is-2 value "2".
         05 in-salary pic 99999.
      *
       fd print-file
           record contains 132 characters
           data record is print-line.
      *
       01 print-line pic x(132).
      *
       working-storage section.
      *
       01 ws-heading1.
         05 filler pic x(30) value "     Name            Errors   ".
      *               ----+----1----+----2----+----3
       01 ws-eof-flag pic x value 'n'.
         88 ws-yes value "y".
      *
       01 ws-detail-line.
         05 filler pic x(5).
         05 ws-dl-nam pic x(10).
         05 filler pic x(5).
         05 ws-dl-error1 pic x(20).
         05 filler pic x(5).
         05 ws-dl-error2 pic x(20).
         05 filler pic x(5).
         05 ws-dl-error3 pic x(20).
         05 filler pic x(5).
         05 filler pic x(37).

       01 ws-errors pic 9 value 0.
         88 ws-errorfree value 0.
         88 ws-oneerror value 1.
         88 ws-twoerrors value 2.
         88 ws-threeerrors value 3.
      *
       procedure division.
      *
       000-main.
      *
           open input in-file,
             output print-file.
      *
           read in-file
               at end
                   move 'y' to ws-eof-flag.
      *
           write print-line from ws-heading1 before advancing 2 lines.
      *
           move " " to ws-dl-nam.
           move " " to ws-dl-error1.
           move " " to ws-dl-error2.
           move " " to ws-dl-error3.
           perform 100-process-logic until ws-yes.
      *
           close in-file,
             print-file.
      *
           display "Press ENTER to run program 2".
           accept return-code.
           call "T2-01-P2".
           stop run.
      *
       100-process-logic.
      *
      *    write print-line from ws-detail-line after advancing 2 lines.
      *
           read in-file
               at end
                   move 'y' to ws-eof-flag
               not at end
                   perform 150-processinfo.
      *
       150-processinfo.
      *all the correct values will be displayed on the console line
      *the incorrect values will be displayed on the report.
           move 0 to ws-errors.
           move " " to ws-dl-error1.
           move " " to ws-dl-error2.
           move " " to ws-dl-error3.
           perform checkNumber.
           perform shiftCode.
           perform jobClass.
           
           write print-line from ws-detail-line.
      *reset
           move " " to ws-dl-nam.
           move 0 to ws-errors.

       checkNumber.
           if in-number is numeric then
      *0
           else
      *1
               add 1 to ws-errors
               move in-name to ws-dl-nam
               move "INVALID NUMBER" to ws-dl-error1
           end-if.

       shiftCode.
           if is-day OR is-night then

      *0 or 1
           else
      *if 0 or 1
               move in-name to ws-dl-nam
      * 1
               add 1 to ws-errors

               if ws-oneerror then
                   move "INVALID SHIFT CODE" to ws-dl-error1
               end-if

               if ws-twoerrors then
                   move "INVALID SHIFT CODE" to ws-dl-error2
               end-if
           end-if.

       jobClass.
           if is-1 OR is-2 then

           else
      *0, 1, or 2
               move in-name to ws-dl-nam
      *2
               add 1 to ws-errors

               if ws-oneerror then
                   move "INVALID JOB CLASS" to ws-dl-error1
               end-if

               if ws-twoerrors then
                   move "INVALID JOB CLASS" to ws-dl-error2
               end-if

               if ws-threeerrors then
                   move "INVALID JOB CLASS" to ws-dl-error3
               end-if
           end-if

       end program T2-02-P1.
