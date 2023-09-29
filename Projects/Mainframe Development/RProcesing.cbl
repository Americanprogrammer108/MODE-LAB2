       identification division.
       program-id. RProcessing.
       author. Vishwa Patel.
       date-written. 2023-04-19.
      *Program Description: This is the program 4 which read data from
      * valid R records and display the tax owned and total as
      * output report.

       environment division.
       input-output section.
       file-control.
      *Open input file.
           select input-file
           assign to "../data/r.dat"
           organization is line sequential.
      *Open output file.
           select output-file
           assign to "../data/returnreport.out"
           organization is line sequential.

       data division.

       file section.

      *Collecting the data from input file.
       fd input-file
           data record is input-line
           record contains 36 characters.

       01 input-line.
           05 il-transactioncode pic x(1).
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
           05 il-invoicenumber pic x(9).
           05 il-skucode pic x(15).
      *Print it out to output file.
       fd output-file
           data record is output-line
           record contains 200 characters.

       01 output-line pic x(200).

       working-storage section.
       01 ws-eof-flag pic x(1).
         88 ws-yes value "y".

       01 ws-totalR-Amounts pic 999999.

       01 ws-totalRCodes pic 999 value 0.

       01 ws-header.
         05 ws-transactioncode pic x(16) value "TRANSACTION CODE".
         05 filler pic x(10).
         05 ws-transactionamount pic x(18) value "TRANSACTION AMOUNT".
         05 filler pic x(10).
         05 ws-paymenttype pic x(12) value "PAYMENT TYPE".
         05 filler pic x(10).
         05 ws-storenumber pic x(12) value "STORE NUMBER".
         05 filler pic x(10).
         05 ws-invoicenumber pic x(14) value "INVOICE NUMBER".
         05 filler pic x(10).
         05 ws-skuCode pic x(8) value "SKU CODE".
         05 filler pic x(17).
         05 ws-taxowing pic x(10) value "TAX OWING".

       01 ws-info.
         05 ws-outtransactioncode pic x(1).
         05 filler pic x(25) value spaces.
         05 ws-outtransactionamount pic ZZ,ZZ9.99.
         05 filler pic x(19) value spaces.
         05 ws-outpaymenttype pic x(2).
         05 filler pic x(20) value spaces.
         05 ws-outstorenumber pic x(2).
         05 filler pic x(20) value spaces.
         05 ws-outinvoicenumber pic x(9).
         05 filler pic x(15) value spaces.
         05 ws-outskucode pic x(15).
         05 filler pic x(10) value spaces.
         05 ws-taxtoowe pic ZZ,ZZ9.99.

       01 ws-calculatetax pic 99999v99.

       01 ws-pageinfo.
         05 ws-pageheader pic x(5) value "PAGE ".
         05 ws-pagenumber pic 99 value 0.

       01 ws-counter pic 99 value 0.
         88 ws-20 value 20.

       01 ws-pagecount pic 99 value 0.


       01 ws-totalheaderR.
         05 ws-total-Rrecords pic x(15) value "Total R Records".
         05 filler pic x(5) value spaces.
         05 ws-allRRecords pic ZZ9.


       01 ws-totalofallrecords.
         05 ws-total-Lrecords pic x(20) value "Total of all records".
         05 filler pic x(5) value spaces.
         05 ws-totalofRecords pic ZZ9.


       01 ws-totalRAmounts.
         05 ws-allL pic x(15) value "Total R Amount".
         05 filler pic x(5) value spaces.
         05 ws-allAmountsR pic ZZ,ZZ9.99.


       01 ws-totaldisplay.
         05 ws-message pic x(20) value "Total store amount".
         05 ws-taxtotal-display pic ZZZ,ZZ9.99.

       01 ws-totaltaxesdisplay.
         05 ws-message pic x(20) value "Total tax amount".
         05 ws-taxestotal-display pic ZZZ,ZZ9.99.

       01 ws-total-taxowingdisplay.
         05 ws-message pic x(25) value "Total tax amount for R: ".
         05 ws-taxestotal-displayR pic ZZZ,ZZ9.99.

       01 ws-total-taxowingforR pic 99999v99.
       01 ws-totaltaxes pic 99999v99.

       procedure division.

           open input input-file, output output-file.

           write output-line from ws-header.
           perform 050-readfile until ws-yes.
           add 1 to ws-pagenumber.


           write output-line from ws-pageinfo before advancing 2 lines.

           write output-line from "SALES REPORT SUMMARY"
             before advancing 2 lines.
           move ws-totalRCodes to ws-allRRecords.
           add ws-totalRCodes to ws-totalRCodes
             giving ws-totalofRecords.


           write output-line from ws-totalheaderR.
           write output-line from ws-totalofallrecords before
             advancing 2 lines.

           move ws-totalR-Amounts to ws-allAmountsR.


           write output-line from ws-totalRAmounts.


           write output-line from ws-totaldisplay before advancing 2
           lines.


           move ws-total-taxowingforR to ws-taxestotal-displayR.


           write output-line from ws-total-taxowingdisplay.
           write output-line from ws-totaltaxesdisplay.

           close input-file, output-file.

           display "Press Enter.".
           accept return-code
           goback.

       050-readfile.
           read input-file
               at end
                   move "y" to ws-eof-flag
               not at end
                   perform 100-getinfo.
       100-getinfo.
           move il-transactioncode to ws-outtransactioncode.
           move il-transactionamount to ws-outtransactionamount.
           move il-paymenttype to ws-outpaymenttype.
           move il-storenumber to ws-outstorenumber.
           move il-invoicenumber to ws-outinvoicenumber.
           move il-skucode to ws-outskucode.
           perform 150-calculatetax.
           perform calculatetaxes.
           perform calculatetaxowingforR.


           if ws-20 then
               move 0 to ws-counter
               add 1 to ws-pagenumber
               perform getcode
               write output-line from ws-pageinfo
               before advancing 2 lines
           else
               add 1 to ws-counter
               perform getcode
           end-if.




       150-calculatetax.
      *tax is worth 13%
           multiply il-transactionamount by 0.13
             giving ws-taxtoowe, ws-calculatetax.

       getcode.
      *
           if il-RCode then
               add 1 to ws-totalRCodes

           end-if.


      *    end-if.
           write output-line from ws-info.




       calculatetaxes.
           add ws-calculatetax to ws-totaltaxes.

       calculatetaxowingforR.
           if il-RCode then
             add ws-calculatetax to ws-total-taxowingforR
           end-if.

       end program RProcessing.
