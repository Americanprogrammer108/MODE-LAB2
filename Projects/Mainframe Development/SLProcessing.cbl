       identification division.
       program-id. SLProcessing.
       author. Ethan Chen.
       date-written. 2023-04-19.
      *Program Description: This is the program 3 which read data from
      * valid S&L records and display the tax owned and total as
      * output report.

       environment division.
       input-output section.
       file-control.
           select input-file
           assign to "../data/s.dat"
           organization is line sequential.

           select output-file
           assign to "../data/S&LReport.out"
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

       fd output-file
           data record is output-line
           record contains 200 characters.

       01 output-line pic x(200).

       working-storage section.
       01 ws-eof-flag pic x(1).
         88 ws-yes value "y".

       01 ws-totalS-Amounts pic 999999.
       01 ws-totalL-Amounts pic 999999.

       01 ws-totalSCodes pic 999 value 0.
       01 ws-totalLCodes pic 999 value 0.

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

       01 ws-totalpaymenttypes pic 999 value 0.

       01 ws-totalheaderS.
         05 ws-total-Srecords pic x(15) value "Total S Records".
         05 filler pic x(5) value spaces.
         05 ws-allSRecords pic ZZ9.

       01 ws-totalheaderL.
         05 ws-total-Lrecords pic x(15) value "Total L Records".
         05 filler pic x(5) value spaces.
         05 ws-allLRecords pic ZZ9.

       01 ws-totalofallrecords.
         05 ws-total-Lrecords pic x(20) value "Total of all records".
         05 filler pic x(5) value spaces.
         05 ws-totalofRecords pic ZZ9.


       01 ws-totalLAmounts.
         05 ws-allL pic x(15) value "Total L Amount".
         05 filler pic x(5) value spaces.
         05 ws-allAmountsL pic ZZ,ZZ9.99.

       01 ws-totalSAmounts.
         05 ws-allS pic x(15) value "Total S Amount".
         05 filler pic x(5) value spaces.
         05 ws-allAmountsS pic ZZ,ZZ9.99.

       01 ws-totalDebits pic 999 value 0.
       01 ws-totalCredits pic 999 value 0.
       01 ws-totalCash pic 999 value 0.

       01 ws-displaypaymenttypes.
         05 ws-debitmessage pic x(21) value "Total debit payments: ".
         05 ws-debit pic ZZ9.
         05 filler pic x(5) value spaces.
         05 ws-debitmessage pic x(22) value "Total credit payments: ".
         05 ws-credit pic ZZ9.
         05 filler pic x(5) value spaces.
         05 ws-debitmessage pic x(20) value "Total cash payments: ".
         05 ws-cash pic ZZ9.

       01 ws-percentages.
         05 ws-debitmessage pic x(20) value "Debit percentage: ".
         05 ws-debitpercent pic ZZ9.99.
         05 filler pic x(5) value spaces.
         05 ws-debitmessage pic x(22) value "Credit percentage: ".
         05 ws-creditpercent pic ZZ9.99.
         05 filler pic x(5) value spaces.
         05 ws-debitmessage pic x(20) value "Cash percentage: ".
         05 ws-cashpercent pic ZZ9.99.

       01 ws-cashpercentage pic 999v9999.
       01 ws-creditpercentage pic 999v9999.
       01 ws-debitpercentage pic 999v9999.

       01 ws-setinitialhigh pic x value "n".
       01 ws-setinitiallow pic x value "n".

       01 ws-highest pic 9999v99.
       01 ws-lowest pic 9999v99.

       01 ws-displayhighest.
         05 ws-message pic x(20) value "Highest value: ".
         05 ws-highestvalue pic Z,ZZ9.99.
         05 filler pic x(5) value spaces.
         05 ws-message pic x(20) value "Store number: ".
         05 ws-higheststorenumber pic 99.
         05 filler pic x(5) value spaces.                               ue spaces.
         05 ws-message pic x(20) value "Invoice number: ".
         05 ws-highestinvoicenumber pic x(9).


       01 ws-displaylowest.
         05 ws-message pic x(20) value "Lowest value: ".
         05 ws-lowestvalue pic Z,ZZ9.99.
         05 filler pic x(5) value spaces.
         05 ws-message pic x(20) value "Store number: ".
         05 ws-loweststorenumber pic 99.
         05 filler pic x(5) value spaces.                               ue spaces.
         05 ws-message pic x(20) value "Invoice number: ".
         05 ws-lowestinvoicenumber pic x(9).

       01 ws-store1total pic 99999v99.
       01 ws-store2total pic 99999v99.
       01 ws-store3total pic 99999v99.
       01 ws-store4total pic 99999v99.
       01 ws-store5total pic 99999v99.
       01 ws-store12total pic 99999v99.

       01 ws-store1display.
         05 ws-message pic x(20) value "Store 1 totals".
         05 ws-message1 pic ZZZ,ZZ9.99.

       01 ws-store2display.
         05 ws-message pic x(20) value "Store 2 totals".
         05 ws-message2 pic ZZZ,ZZ9.99.

       01 ws-store3display.
         05 ws-message pic x(20) value "Store 3 totals".
         05 ws-message3 pic ZZZ,ZZ9.99.

       01 ws-store4display.
         05 ws-message pic x(20) value "Store 4 totals".
         05 ws-message4 pic ZZZ,ZZ9.99.

       01 ws-store5display.
         05 ws-message pic x(20) value "Store 5 totals".
         05 ws-message5 pic ZZZ,ZZ9.99.

       01 ws-store12display.
         05 ws-message pic x(20) value "Store 12 totals".
         05 ws-message12 pic ZZZ,ZZ9.99.

       01 ws-totaldisplay.
         05 ws-message pic x(20) value "Total store amount".
         05 ws-taxtotal-display pic ZZZ,ZZ9.99.

       01 ws-totaltaxesdisplay.
         05 ws-message pic x(20) value "Total tax amount".
         05 ws-taxestotal-display pic ZZZ,ZZ9.99.

       01 ws-total-taxowingdisplay.
         05 ws-message pic x(25) value "Total tax amount for S: ".
         05 ws-taxestotal-displayS pic ZZZ,ZZ9.99.
         05 filler pic x(5) value spaces.
         05 ws-message pic x(25) value "Total tax amount for L: ".
         05 ws-taxestotal-displayL pic ZZZ,ZZ9.99.

       01 ws-totaltaxes pic 99999v99.

       01 ws-totaltaxes2 pic 99999v99.

      * tax owing is 2,550.53
      *418.60 for l (tax owing)
      *calculate the tax owing for s
      *calculate the tax owing

       01 ws-total-taxowingforS pic 99999v99.
       01 ws-total-taxowingforL pic 99999v99.


       procedure division.

           open input input-file, output output-file.

           write output-line from ws-header.
           perform 050-readfile until ws-yes.
           add 1 to ws-pagenumber.


           write output-line from ws-pageinfo before advancing 2 lines.

           write output-line from "SALES REPORT SUMMARY"
             before advancing 2 lines.
           move ws-totalLCodes to ws-allLRecords.
           move ws-totalSCodes to ws-allSRecords.
           add ws-totalSCodes to ws-totalLCodes
             giving ws-totalofRecords.


           write output-line from ws-totalheaderS.
           write output-line from ws-totalheaderL.
           write output-line from ws-totalofallrecords before
             advancing 2 lines.

           move ws-totalL-Amounts to ws-allAmountsL.
           move ws-totalS-Amounts to ws-allAmountsS.

           write output-line from ws-totalLAmounts.
           write output-line from ws-totalSAmounts
           before advancing 2 lines.

           move ws-totalDebits to ws-debit.
           move ws-totalCredits to ws-credit.
           move ws-totalCash to ws-cash.

           write output-line from ws-displaypaymenttypes.

           add ws-totalDebits to ws-totalpaymenttypes.
           add ws-totalCredits to ws-totalpaymenttypes.
           add ws-totalCash to ws-totalpaymenttypes.

           divide ws-totalDebits by ws-totalpaymenttypes
             giving ws-debitpercentage rounded.

           divide ws-totalCredits by ws-totalpaymenttypes
             giving ws-creditpercentage rounded.

           divide ws-totalCash by ws-totalpaymenttypes
             giving ws-cashpercentage rounded.

      *take the value that was calculated

           move ws-cashpercentage to ws-cashpercent.
           move ws-creditpercentage to ws-creditpercent.
           move ws-debitpercentage to ws-debitpercent.

           multiply 100 by ws-cashpercentage
      *then return
             giving ws-cashpercent

           multiply 100 by ws-creditpercentage
             giving ws-creditpercent

           multiply 100 by ws-debitpercentage
             giving ws-debitpercent

           write output-line from ws-percentages before
             advancing 2 lines.

           move ws-lowest to ws-lowestvalue.
           move ws-highest to ws-highestvalue.

           write output-line from ws-displayhighest.
           write output-line from ws-displaylowest
           before advancing 2 lines.

           move ws-store1total to ws-message1.
           move ws-store2total to ws-message2.
           move ws-store3total to ws-message3.
           move ws-store4total to ws-message4.
           move ws-store5total to ws-message5.
           move ws-store12total to ws-message12.

           add ws-store1total to ws-totaltaxes.
           add ws-store2total to ws-totaltaxes.
           add ws-store3total to ws-totaltaxes.
           add ws-store4total to ws-totaltaxes.
           add ws-store5total to ws-totaltaxes.
           add ws-store12total to ws-totaltaxes
             giving ws-taxtotal-display.

           write output-line from ws-store1display.
           write output-line from ws-store2display.
           write output-line from ws-store3display.
           write output-line from ws-store4display.
           write output-line from ws-store5display.
           write output-line from ws-store12display.
           write output-line from ws-totaldisplay before advancing 2
           lines.

           move ws-totaltaxes2 to ws-taxestotal-display.


           move ws-total-taxowingforL to ws-taxestotal-displayL.
           move ws-total-taxowingforS to ws-taxestotal-displayS.

           write output-line from ws-total-taxowingdisplay.
           write output-line from ws-totaltaxesdisplay.

           close input-file, output-file.

           display "Print finished.".
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
           perform getpaymenttype.
           perform gethighesttransactionamount.
           perform getlowesttransactionamount.
           perform calculate-store1totals.
           perform calculate-store2totals.
           perform calculate-store3totals.
           perform calculate-store4totals.
           perform calculate-store5totals.
           perform calculate-store12totals.
           perform calculatetaxes.
           perform calculatetaxowingforL.
           perform calculatetaxowingforS.

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
      *    if il-SCode OR il-LCode then
           if il-SCode then
               add 1 to ws-totalSCodes
               add il-transactionamount to ws-totalS-Amounts
           end-if.

           if il-LCode then
               add 1 to ws-totalLCodes
               add il-transactionamount to ws-totalL-Amounts
           end-if.

      *    end-if.
           write output-line from ws-info.

       getpaymenttype.
           if il-debit then
               add 1 to ws-totalDebits
           end-if.

           if il-credit then
               add 1 to ws-totalCredits
           end-if.

           if il-cash then
               add 1 to ws-totalCash
           end-if.

       gethighesttransactionamount.
           if ws-setinitialhigh = "n" then
               move "y" to ws-setinitialhigh
               move il-transactionamount to ws-highest
           end-if.
      *let's assume that this value is the highest, right?
      *iv the value is greater than the highest, move the highest value
           if il-transactionamount > ws-highest then
               move il-transactionamount to ws-highest
               move il-storenumber to ws-higheststorenumber
               move il-invoicenumber to ws-highestinvoicenumber
           end-if.

       getlowesttransactionamount.
           if ws-setinitiallow = "n" then
               move "y" to ws-setinitiallow
               move il-transactionamount to ws-lowest
           end-if.
      *let's assume that this value is the highest, right?
      *iv the value is less than the lowest, move the lowest value
           if il-transactionamount < ws-lowest then
               move il-transactionamount to ws-lowest
      *if there is a duplicate or more, include the invoice number
               move il-storenumber to ws-loweststorenumber
               move il-invoicenumber to ws-lowestinvoicenumber
           end-if.

       calculate-store1totals.
           if il-1 then
               add il-transactionamount to ws-store1total
           end-if.

       calculate-store2totals.
           if il-2 then
               add il-transactionamount to ws-store2total
           end-if.

       calculate-store3totals.
           if il-3 then
               add il-transactionamount to ws-store3total
           end-if.

       calculate-store4totals.
           if il-4 then
               add il-transactionamount to ws-store4total
           end-if.

       calculate-store5totals.
           if il-5 then
               add il-transactionamount to ws-store5total
           end-if.

       calculate-store12totals.
           if il-12 then
               add il-transactionamount to ws-store12total
           end-if.

       calculatetaxes.
           add ws-calculatetax to ws-totaltaxes2.

       calculatetaxowingforS.
           if il-SCode then
             add ws-calculatetax to ws-total-taxowingforS
           end-if.
       calculatetaxowingforL.
           if il-LCode then
             add ws-calculatetax to ws-total-taxowingforL
           end-if.

       end program SLProcessing.
