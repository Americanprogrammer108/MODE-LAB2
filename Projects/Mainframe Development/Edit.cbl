       identification division.
       program-id. edit.
       author. Hifza Hameed.
       environment division.
       input-output section.
       file-control.
           select input-file
           assign to "../data/Project8.dat"
           organization is line sequential.

           select report-file
           assign to "../data/Report.out"
           organization is line sequential.

           select invalid-file
           assign to "../data/InValid-Records.out"
           organization is line sequential.

           select valid-file
           assign to "../data/Valid-Records.out"
           organization is line sequential.

       data division.
       file section.

       fd input-file
           data record is input-line
           record contains 36 characters.
       01 input-line.
         05 il-transactioncode pic x(1).
           88 il-SCode value "S".
           88 il-LCode value "L".
           88 il-RCode value "R".
         05 il-transactionamount pic 99999v99.
         05 il-paymenttype pic x(2).
           88 il-debit value "DB".
           88 il-credit value "CR".
           88 il-cash value "CA".
         05 il-storenumber pic x(2).
           88 il-1 value "01".
           88 il-2 value "02".
           88 il-3 value "03".
           88 il-4 value "04".
           88 il-5 value "05".
           88 il-12 value "12".
         05 il-invoicenumber1a pic x(1).
         05 il-invoicenumber1b pic x(1).
         05 il-invoicenumber2 pic x(1).
         05 il-invoicenumber3 pic x(6).
         05 il-skucode pic x(15).

       fd report-file
           data record is report-line
           record contains 200 characters.
       01 report-line pic x(200).

       fd invalid-file
           data record is invalid-line
           record contains 500 characters.
       01 invalid-line pic x(500).

       fd valid-file
           data record is valid-line
           record contains 200 characters.
       01 valid-line pic x(200).

       01 ws-eof pic x value "n".
         88 ws-yes value "y".


       working-storage section.

       01 ws-details.
         05 ws-transactioncode pic x.
         05 filler pic x(5) value spaces.
         05 ws-transactionamount pic 99999v99.
         05 filler pic x(5) value spaces.
         05 ws-paymenttype pic x(2).
         05 filler pic x(5) value spaces.
         05 ws-storenumber pic x(2).
         05 filler pic x(5) value spaces.
         05 ws-invoicenumber1a pic x(1).
         05 filler pic x(5) value spaces.
         05 ws-invoicenumber1b pic x(1).
         05 filler pic x(5) value spaces.
         05 ws-invoicenumber2 pic x(1) value "-".
         05 filler pic x(5) value spaces.
         05 ws-invoicenumber3  pic x(6).
         05 filler pic x(5) value spaces.
         05 ws-sku pic x(15).
         05 filler pic x(5) value spaces.

       01 invalidrecordsfile.
         05 incorrect-transactioncode pic x.
         05 incorrect-transactionamount pic 9(5)V99.
         05 incorrect-paymenttype pic x(2).
         05 incorrect-storenumber pic x(2).
         05 incorrect-invoicenumber1 pic x(1).
         05 incorrect-invoicenumber2 pic x(1).
         05 incorrect-invoicenumber3 pic x(1) value "-".
         05 incorrect-invoicenumber4 pic x(6).
         05 incorrect-skucode pic x(15).

       01 invalidrecordsinfo.
         05 transactioncode pic x.
         05 filler pic x(5) value spaces.
         05 transactionamount pic 9(5)V99.
         05 filler pic x(5) value spaces.
         05 paymenttype pic x(2).
         05 filler pic x(5) value spaces.
         05 storenumber pic x(2).
         05 filler pic x(5) value spaces.
         05 invoicenumber-1 pic x(1).
         05 invoicenumber-2 pic x(1).
         05 invoicenumber-3 pic x(1).
         05 invoicenumber-4 pic x(6).
         05 filler pic x(5) value spaces.
         05 skucode pic x(15).
         05 filler pic x(10) value spaces.
         05 error1 pic x(25).
         05 filler pic x(10) value spaces.
         05 error2 pic x(25).
         05 filler pic x(10) value spaces.
         05 error3 pic x(25).
         05 filler pic x(10) value spaces.
         05 error4 pic x(25).
         05 filler pic x(10) value spaces.
         05 error5 pic x(25).
         05 filler pic x(10) value spaces.
         05 error6 pic x(25).
         05 filler pic x(10) value spaces.
         05 error7 pic x(25).
         05 filler pic x(10) value spaces.
         05 error8 pic x(25).
         05 filler pic x(10) value spaces.
         05 error9 pic x(25).

       01 ws-errors pic 99 value 00.

       01 validrecordsinfo.
         05 correct-transactioncode pic x.
         05 correct-transactionamount pic 9(5)V99.
         05 correct-paymenttype pic x(2).
         05 correct-storenumber pic x(2).
         05 correct-invoicenumber1 pic x(1).
         05 correct-invoicenumber2 pic x(1).
         05 correct-invoicenumber3 pic x(1) value "-".
         05 correct-invoicenumber4 pic x(6).
         05 correct-skucode pic x(15).

       procedure division.
           open input input-file.
           open output invalid-file, report-file, valid-file.
           write report-line from "RECORDS & ERROR REPORT"
             before advancing 2 lines.
           move 0 to ws-errors.

           perform read-file until ws-yes.

           close input-file, invalid-file, report-file, valid-file.
           display "Print finished".
           accept return-code.
           goback.

       read-file.
           read input-file
               at end
                   move "y" to ws-eof
               not at end
                   perform 100-getinfo.


       100-getinfo.
           perform getrecords
           perform gettransactionamount
           perform getpaymenttype
           perform getstorenumber
           perform getinvoicenumber1
           perform getinvoicenumber2
           perform getinvoicenumber2b
           perform getinvoicenumber3
           perform getskucode

           if ws-errors = 0 then
               write valid-line from validrecordsinfo
           else
               write report-line from invalidrecordsinfo
               write invalid-line from invalidrecordsfile
           end-if
           move 0 to ws-errors.




       getrecords.

           if il-RCode OR il-SCode OR il-LCode then
               move il-transactioncode to correct-transactioncode
           else
               add 1 to ws-errors
               move il-transactioncode to transactioncode
               move il-transactioncode to incorrect-transactioncode
               move "INVALID CODE" to error1

           end-if.


       gettransactionamount.
           if il-transactionamount is numeric then
               move il-transactionamount to correct-transactionamount
           else
               add 1 to ws-errors
               move il-transactionamount to transactionamount
               move il-transactionamount to incorrect-transactionamount
               if ws-errors = 2 then
                   move "INVALID AMOUNT" to error1
               end-if

               if ws-errors = 1 then
                   move "INVALID AMOUNT" to error1
               end-if
           end-if.

       getpaymenttype.
           if il-debit OR il-credit OR il-cash then
               move il-paymenttype to correct-paymenttype
           else
               add 1 to ws-errors
               move il-paymenttype to paymenttype
               move il-paymenttype to incorrect-paymenttype

               if ws-errors = 3 then
                   move "INVALID PAYMENT" to error3
               end-if

               if ws-errors = 2 then
                   move "INVALID PAYMENT" to error2
               end-if
               if ws-errors = 1 then
                   move "INVALID PAYMENT" to error1
               end-if

           end-if.

       getstorenumber.
           if il-1 OR il-2 OR il-3 OR il-4 OR il-5 OR il-12 then
               move il-storenumber to correct-storenumber
           else
               add 1 to ws-errors
               move il-storenumber to storenumber
               move il-storenumber to incorrect-storenumber

               if ws-errors = 4 then
                   move "INVALID STORE NUMBER" to error4
               end-if

               if ws-errors = 3 then
                   move "INVALID STORE NUMBER" to error3
               end-if

               if ws-errors = 2 then
                   move "INVALID STORE NUMBER" to error2
               end-if

               if ws-errors = 1 then
                   move "INVALID STORE NUMBER" to error1
               end-if
           end-if.

       getinvoicenumber1.
           if il-invoicenumber3 > 100000 AND il-invoicenumber3 < 900000
             then
               move il-invoicenumber3 to correct-invoicenumber4
           else
               add 1 to ws-errors
               move il-invoicenumber3 to invoicenumber-4
               move il-invoicenumber3 to incorrect-invoicenumber4

               if ws-errors = 5 then
                   move "INVALID INVOICE NUMBER" to error5
               end-if

               if ws-errors = 4 then
                   move "INVALID INVOICE NUMBER" to error4
               end-if

               if ws-errors = 3 then
                   move "INVALID INVOICE NUMBER" to error3
               end-if

               if ws-errors = 2 then
                   move "INVALID INVOICE NUMBER" to error2
               end-if

               if ws-errors = 1 then
                   move "INVALID INVOICE NUMBER" to error1
               end-if
           end-if.

       getinvoicenumber2.
           if il-invoicenumber1a = "A" OR il-invoicenumber1a = "B"
             OR il-invoicenumber1a = "C" OR il-invoicenumber1a = "D"
             OR il-invoicenumber1a = "E" then
               move il-invoicenumber1a to correct-invoicenumber1
           else
               add 1 to ws-errors
               move il-invoicenumber1a to invoicenumber-1
               move il-invoicenumber1a to incorrect-invoicenumber1
               if ws-errors = 6 then
                   move "INVALID VOICE NUMBER 1A" to error6
               end-if

               if ws-errors = 5 then
                   move "INVALID VOICE NUMBER 1A" to error5
               end-if

               if ws-errors = 4 then
                   move "INVALID VOICE NUMBER 1A" to error4
               end-if

               if ws-errors = 3 then
                   move "INVALID VOICE NUMBER 1A" to error3
               end-if

               if ws-errors = 2 then
                   move "INVALID VOICE NUMBER 1A" to error2
               end-if
               if ws-errors = 1 then
                   move "INVALID VOICE NUMBER 1A" to error1
               end-if
           end-if.
           perform getinvoicenumber2b.

       getinvoicenumber2b.
           if il-invoicenumber1b = "A" OR il-invoicenumber1b = "B"
             OR il-invoicenumber1b = "C" OR il-invoicenumber1b = "D"
             OR il-invoicenumber1b = "E" then
               move il-invoicenumber1a to correct-invoicenumber1
           else
               add 1 to ws-errors
               if ws-errors = 7 then
                   move "INVALID VOICE NUMBER 1B" to error6
               end-if

               if ws-errors = 6 then
                   move "INVALID VOICE NUMBER 1B" to error6
               end-if

               if ws-errors = 5 then
                   move "INVALID VOICE NUMBER 1B" to error5
               end-if

               if ws-errors = 4 then
                   move "INVALID VOICE NUMBER 1B" to error4
               end-if

               if ws-errors = 3 then
                   move "INVALID VOICE NUMBER 1B" to error3
               end-if

               if ws-errors = 2 then
                   move "INVALID VOICE NUMBER 1B" to error2
               end-if
               if ws-errors = 1 then
                   move "INVALID VOICE NUMBER 1B" to error1
               end-if

               move il-invoicenumber1b to invoicenumber-3
               move il-invoicenumber1b to incorrect-invoicenumber3
           end-if.


       getinvoicenumber3.
           if il-invoicenumber1a = il-invoicenumber1b then
               add 1 to ws-errors
               move il-invoicenumber1a to incorrect-invoicenumber1
               move il-invoicenumber1b to incorrect-invoicenumber2

               if ws-errors = 8 then
                   move "SAME LETTER" to error8
               end-if

               if ws-errors = 7 then
                   move "SAME LETTER" to error7
               end-if

               if ws-errors = 6 then
                   move "SAME LETTER" to error6
               end-if

               if ws-errors = 5 then
                   move "SAME LETTER" to error5
               end-if

               if ws-errors = 4 then
                   move "SAME LETTER" to error4
               end-if

               if ws-errors = 3 then
                   move "SAME LETTER" to error3
               end-if

               if ws-errors = 2 then
                   move "SAME LETTER" to error2
               end-if

               if ws-errors = 1 then
                   move "SAME LETTER" to error1
               end-if
           else
               move il-invoicenumber1a to correct-invoicenumber1
               move il-invoicenumber1b to correct-invoicenumber2

           end-if.

       getskucode.
           if il-skucode = spaces then
               add 1 to ws-errors
               move il-skucode to skucode
               move il-skucode to incorrect-skucode
               if ws-errors = 9 then
                   move "EMPTY SKU CODE" to error9
               end-if
               if ws-errors = 8 then
                   move "EMPTY SKU CODE" to error8
               end-if
               if ws-errors = 7 then
                   move "EMPTY SKU CODE" to error7
               end-if
               if ws-errors = 6 then
                   move "EMPTY SKU CODE" to error6
               end-if
               if ws-errors = 5 then
                   move "EMPTY SKU CODE" to error5
               end-if
               if ws-errors = 4 then
                   move "EMPTY SKU CODE" to error4
               end-if
               if ws-errors = 3 then
                   move "EMPTY SKU CODE" to error3
               end-if
               if ws-errors = 2 then
                   move "EMPTY SKU CODE" to error2
               end-if
               if ws-errors = 1 then
                   move "EMPTY SKU CODE" to error1
               end-if

           else
               move il-skucode to correct-skucode
           end-if.

       end program edit.
