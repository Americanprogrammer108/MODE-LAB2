       identification division.
       program-id. Program1.

       environment division.
       configuration section.
       input-output section.

       file-control.
           select input-file
           assign to "../../../A7.dat"
           organization is line sequential.

           select output-file
           assign to "../../../A7-CallCenterOpReport.out"
           organization is line sequential.

       data division.
       file section.

       fd input-file
           data record is emp-rec
           record contains 51 characters.
      *
       01 emp-rec.
         05 emp-rec-num pic x(3).
         05 emp-rec-name pic x(12).
         05 emp-rec-calls pic 999 OCCURS 12 times.
           88 emp-zero value 0.
      *
       fd output-file
           data record is output-line
           record contains 200 characters.
      *
       01 output-line pic x(200).
      *

       working-storage section.
       01 ws-table.
         05 ws-element pic 9.
       01 ws-index pic 999.
       01 ws-counter pic 999.
       01 ws-x pic 99.

       01 ws-constants.
         05 ws-number-of-months pic 99 value 12.
      *
       01 ws-calculated-fields.
         05 ws-non-zero-month-count pic 9(2) value 0.
      *
       01 ws-eof-flag pic x value 'n'.
         88 ws-end-of-file value "y".
      *
       01 ws-totals.
         05 ws-grand-total pic 9(5) value 0.
         05 ws-emp-total pic 9(5) value 0.
         05 ws-total-no-calls pic 9(5) value 0.
      *
       01 ws-totalmonthswithnocalls pic 99.

       01 ws-totalcountwithoutzero pic 99.

       01 ws-name-line.
         05 filler pic x(5) value spaces.
         05 filler pic x(25) value '    Ethan Chen    '.
      *               ----+----1----+----2----+
         05 filler pic x(29) value '                        lab 7'.
      *               ----+----1----+----2----+----
         05 filler pic x(5) value spaces.
         05 ws-name-line-date pic 9(6).
         05 filler pic x(4) value spaces.
         05 ws-name-line-time pic 9(8).
         05 filler pic x(50) value spaces.

      *for those who have a value of 0
       01 ws-nomonthcalls pic 99 value 0.

      *for those who have a value greater than 0
       01 ws-numbermonthcalls pic 999.

      *to calculate the total of calls
       01 ws-totalcalls pic 99.
         88 ws-totalcallsofzero value 0.

      *to calculate the value
       01 ws-totalvalue pic 99999.
       01 ws-totalaverage pic 99999.
       01 ws-displaytotalaverage pic 99999.
       01 ws-remaindertotal pic 999.
       

      *to calculate the value of the total calls
       01 ws-overalltotalcalls pic 99999.

       01 ws-getcount OCCURS 12 times.
           05 ws-count pic 999 value 0.

       01 ws-nomonths pic 99 value 0.

       01 ws-low pic 999.
       01 ws-high pic 999.
       01 ws-move-once pic 9.
       01 ws-move-once2 pic 9.
       01 ws-move-once3 pic 9.


      *month count
       01 ws-july-count pic 999.
       01 ws-august-count pic 999.
       01 ws-september-count pic 999.
       01 ws-october-count pic 999.
       01 ws-november-count pic 999.
       01 ws-december-count pic 999.
       01 ws-january-count pic 999.
       01 ws-february-count pic 999.
       01 ws-march-count pic 999.
       01 ws-april-count pic 999.
       01 ws-may-count pic 999.
       01 ws-june-count pic 999.

       01 ws-highest-average pic 999.
       01 ws-lowest-average pic 999.

       01 ws-highestmonthcall pic 999.

       01 ws-gettotal pic 9999.

       01 ws-totaltotals pic 99999.
       01 ws-averagetotals pic 99999.

      *to calculate the total operator with no calls
       01 ws-operators-with-no-calls pic 99.
      *
       01 ws-report-heading.
         05 filler pic x(40) value spaces.
         05 filler pic x(40) value
                   'Call Center Volumes for July - June     '.
      *               ----+----1----+----2----+----3----+----4
         05 filler pic x(40) value spaces.
         05 filler pic x(12) value spaces.
      *
       01 ws-heading-line1.
         05 filler pic x(2) value spaces.
         05 filler pic x(15) value 'Operator Number'.
         05 filler pic x(2) value spaces.
         05 filler pic x(13) value 'Operator Name'.
         05 filler pic x(6) value spaces.
         05 filler pic x(3) value 'Jul'.
         05 filler pic x(5) value spaces.
         05 filler pic x(3) value 'Aug'.
         05 filler pic x(5) value spaces.
         05 filler pic x(3) value 'Sep'.
         05 filler pic x(5) value spaces.
         05 filler pic x(3) value 'Oct'.
         05 filler pic x(5) value spaces.
         05 filler pic x(3) value 'Nov'.
         05 filler pic x(5) value spaces.
         05 filler pic x(3) value 'Dec'.
         05 filler pic x(5) value spaces.
         05 filler pic x(3) value 'Jan'.
         05 filler pic x(5) value spaces.
         05 filler pic x(3) value 'Feb'.
         05 filler pic x(5) value spaces.
         05 filler pic x(3) value 'Mar'.
         05 filler pic x(5) value spaces.
         05 filler pic x(3) value 'Apr'.
         05 filler pic x(5) value spaces.
         05 filler pic x(3) value 'May'.
         05 filler pic x(5) value spaces.
         05 filler pic x(3) value 'Jun'.
         05 filler pic x(5) value spaces.
         05 filler pic x(5) value 'Total'.
         05 filler pic x(5) value spaces.
         05 filler pic x(7) value 'Average'.
         05 filler pic x(5) value spaces.
         05 filler pic x(9) value 'Remainder'.
         05 filler pic x(3) value spaces.

       01 ws-total-calls pic 99999.
       01 ws-monthaverage pic 999.
      *
       01 ws-detail-line.
         05 filler pic x(4) value spaces.
         05 ws-detail-line-num pic x(3).
         05 filler pic x(12) value spaces.
         05 ws-detail-line-name pic x(12).
         05 filler pic x(7) value spaces.
         05 ws-detail-months occurs 12 times.
           10 ws-detail-line-months pic ZZ9.
           10 filler pic x(5) value spaces.
         05 ws-detail-line-total pic ZZZZ9.
         05 filler pic x(5) value spaces.
         05 ws-detail-line-avg pic zzzz9.
         05 filler pic x(7) value spaces.
         05 ws-detail-line-rem pic 9.
         05 filler pic x(84) value spaces.
      *

      *add the total months who have a value of 0
       01 ws-totalmonths-with-zero-calls pic 99999 value 0.

      *add the total months who don't have a value of 0
       01 ws-totalmonths-without-zero-calls pic 99999.

      *those with months who have a value > 0
       01 ws-totalmonths-without-zero pic 99999.

       01 ws-alltotals pic 99999.


       01 ws-total-line1.
         05 filler pic x(35) value
                   "Number of Operators with no calls: ".
      *               ----+----1----+----2----+----3----+
         05 ws-total-line-no-calls pic zzzz9.
         05 filler pic x(10) value spaces.
      *
       01 ws-total-line2.
         05 filler pic x(35) value
                   "Number of months with no calls:    ".
      *               ----+----1----+----2----+----3----+
         05 ws-total-line-zero-mths pic zzzz9.
         05 filler pic x(10) value spaces.
      *
       01 ws-total-line3.
         05 filler pic x(35) value
                   "Overall total calls:               ".
      *               ----+----1----+----2----+----3----+
         05 ws-total-line-calls pic zzzz9.
         05 filler pic x(86) value spaces.

       01 ws-total-line4.
         05 filler pic x(20) value "Operators with Calls".
         05 filler pic x(19) value spaces.
         05 ws-total-operators OCCURS 12 times.
           10 ws-total-operators-with-calls pic 99 value 0.
           10 filler pic x(6) value spaces.

       01 ws-total-line5.
         05 filler pic x(33) value "Totals".
         05 ws-totals OCCURS 15 times.
           10 filler pic x(3).
           10 ws-detail-totals pic 99999.

       01 ws-total-line6.
         05 filler pic x(10) value "Averages".
         05 filler pic x(27) value " ".
         05 ws-averagesformonth OCCURS 12 times.
           10 ws-averagepermonth pic ZZZ9.
           10 filler pic x(4).

       01 ws-total-line7.
         05 filler pic x(43) value 
         "Operator with the Highest Monthly Average: ".
         05 ws-highestaverage pic 999.
         05 filler pic x(10) value spaces.
         05 ws-highestmonthlycode pic x(3).

       01 ws-total-line8.
         05 filler pic x(42) value 
         "Operator with the Lowest Monthly Average: ".
         05 ws-lowestaverage pic 999.
         05 filler pic x(10) value spaces.
         05 ws-lowestmonthlycode pic x(3).

       01 ws-total-line9.
         05 filler pic x(42) value 
         "Month with the Highest Monthly Average: ".
         05 ws-monthhighestaverage pic 999.

       procedure division.

           open input input-file.
           open output output-file.
           move 0 to ws-move-once.
           move 0 to ws-move-once2.
           move 0 to ws-move-once3.
           write output-line from ws-name-line.
           write output-line from ws-report-heading.

           write output-line from ws-heading-line1.

           perform 050-getinput until ws-end-of-file.

           move ws-nomonths to ws-total-line-no-calls.
           write output-line from " ".

           perform 150-calculateaveragebymonth.

           move ws-displaytotalaverage to ws-detail-totals(14).
           move ws-remaindertotal to ws-detail-totals(15).

           write output-line from ws-total-line4.
           write output-line from ws-total-line5.
           write output-line from ws-total-line6.

           write output-line from " ".
           write output-line from ws-total-line1.
           write output-line from ws-total-line2.
           write output-line from ws-total-line3.

      *    perform varying ws-index from 1 by 1 until ws-index > 12
      *        display ws-detail-line-avg
      *    end-perform


      *write the averages
           write output-line from " ".
           write output-line from ws-total-line7.
           write output-line from ws-total-line8.
           write output-line from ws-total-line9.

           display "print finished".
           close input-file, output-file.
           accept return-code.
           goback.

       050-getinput.
           read input-file
               at end
                   move "y" to ws-eof-flag
               not at end
                   perform 100-getdetails.

       100-getdetails.
           move emp-rec-num to ws-detail-line-num.
           move emp-rec-name to ws-detail-line-name.
           move 0 to ws-detail-line-total.
           move 0 to ws-numbermonthcalls.
           
           perform varying ws-index from 1 by 1 until ws-index > 12
      * move the values to their positions

      *if the total is 0, add 1 to ws-nomonthcalls

      *we need to make sure that the value of each month is not 0
               move emp-rec-calls(ws-index) to ws-detail-line-months(
                   ws-index)

               if not emp-rec-calls(ws-index) = 0 then
                   add 1 to ws-numbermonthcalls
                   add emp-rec-calls(ws-index) to ws-totalvalue
               else
                   add 1 to ws-totalmonths-with-zero-calls
               end-if

      *let's calculate the total value by month

               add emp-rec-calls(ws-index) to ws-detail-totals(
                   ws-index)
               

               

               add emp-rec-calls(ws-index) to ws-alltotals
                 


               if not emp-rec-calls(ws-index) = 0 then
                   add 1 to ws-total-operators-with-calls(ws-index)
               end-if
               

      *now the months with no calls

               
                                                  

      *if there is a value of 0 in ws-detail-months(ws-index)
               if ws-alltotals = 0 then
                   add 1 to ws-nomonthcalls
                   
               end-if

               move ws-detail-totals(ws-index) to ws-gettotal
               
               if ws-move-once3 = 0 then
                   add 1 to ws-move-once3
                   move ws-detail-line-months(ws-index) to 
                     ws-highestmonthcall
               end-if

               


      *now, calculate the averages
      *        divide ws-detail-totals(ws-index) into

           end-perform.

           move ws-alltotals to ws-total-line-calls.
           move ws-totalvalue to ws-detail-line-total.

           
           add ws-totalvalue to ws-detail-totals(13).
           


           if ws-totalvalue = 0 then
               add 1 to ws-nomonths 
           end-if
           
           move ws-totalmonths-with-zero-calls to
             ws-total-line-zero-mths.

      *ws-index does not become available after the perform is finished.
           perform 150-calculateaverage.
           perform 150-calculateaveragebymonth.



           perform 200-gethighestaverage.
           perform 250-getlowestaverage.
           write output-line from ws-detail-line.

       100-calculatetotals.
           perform varying ws-counter from 1 by 1 until ws-counter > 2

           end-perform.

       150-calculateaverage.
           divide ws-totalvalue by ws-numbermonthcalls
             giving ws-detail-line-avg rounded
           remainder ws-detail-line-rem.

           add ws-detail-line-rem to ws-remaindertotal

           divide ws-totalvalue by ws-numbermonthcalls
             giving ws-totalaverage.
           add ws-totalaverage to ws-displaytotalaverage.
           
             
      *    display ws-detail-totals(14).
           move 0 to ws-totalvalue.
      *


       150-calculateaveragebymonth.
           perform varying ws-index from 1 by 1 until ws-index > 12
               divide ws-detail-totals(ws-index) by
                 ws-total-operators-with-calls(ws-index)
                 giving ws-averagepermonth(ws-index), ws-averagetotals
               move ws-averagepermonth(ws-index) to ws-averagepermonth(
                   ws-index)
           end-perform.
           move ws-averagetotals to ws-detail-totals(14).

       200-gethighestaverage.
           if ws-move-once2 = 0 then
               add 1 to ws-move-once2
               move ws-totalaverage to ws-high
           end-if.
           if ws-totalaverage > ws-high then
               move ws-totalaverage to ws-high
               move ws-high to ws-highestaverage
               move ws-detail-line-num to ws-highestmonthlycode
           end-if.

       250-getlowestaverage.
      *we'll start with the first value
           if ws-move-once = 0 then
               add 1 to ws-move-once
               move ws-totalaverage to ws-low
           end-if.

      *then, as we go on, we will evaluate if the value is less than the
      *actual one
           if ws-totalaverage is < ws-low then
               move ws-totalaverage to ws-low
               move ws-low to ws-lowestaverage
               move ws-detail-line-num to ws-lowestmonthlycode
           end-if.



       end program Program1.