       identification division.
       program-id. SplitAndCount.
      *Written by samreet singh sandhu
       environment division.
       input-output section.
       file-control.

           select valid-file
               assign to '../Valid-Records.out'
               organization is line sequential.

           select s-file
               assign to '../s.dat'
               organization is line sequential.
           select r-file
               assign to '../r.dat'
               organization is line sequential.
           select counts-file
               assign to '../cnt.out'
               organization is line sequential.


       data division.
       file section.

       fd valid-file
           data record is valid-line
           record contains 36 characters.


       01 valid-line.
           05 valid-file-transaction-code      pic X.
           05 valid-file-tran-ammount          pic 9(5)V99.
           05 valid-file-pament-type           pic XX.
           05 valid-file-store-number          pic 99.
           05 valid-file-invoice-number        pic X(9).
           05 valid-file-sku-code              pic x(15).

       fd s-file
           data record is s-line
           record contains 50 characters.

       01 s-line                               pic x(132).
       fd r-file
           data record is r-line
           record contains 50 characters.
       01 r-line                               pic x(132).

       fd  counts-file
           data record is counts-line
           record contains 36 characters.
       01 counts-line                          pic x(40).

       working-storage section.
       01 ws-detail-line                       pic x(40).


       01 ws-counts.
           05 ws-counts-total-sl               pic 99
               value 0.
           05 ws-counts-total-s                pic 99
               value 0.
           05 ws-counts-total-l                pic 99
               value 0.
           05 ws-counts-total-r                pic 99
               value 0.
       01 ws-amounts.
           05 ws-amounts-total-sl              pic 9(7)v99
               value 0.
           05 ws-amounts-total-s               pic 9(7)v99
               value 0.
           05 ws-amounts-total-l               pic 9(7)v99
               value 0.
           05 ws-amounts-total-r               pic 9(7)v99
               value 0.
       01 ws-eof-flag                          pic x
               value 'n'.
       01 details-counts-sl.
           05 filler                           pic x(29)
               value "Total number of S&L records: ".
           05 ws-line-sl-cnt                   pic z9.
       01 detail-counts-s.
           05 filler                           pic x(28)
               value "Total number of S records: ".
           05 ws-line-s-cnt                    pic z9.
       01 detail-counts-l.
           05 filler                           pic x(28)
               value "Total number of L records: ".
           05 ws-line-l-cnt                    pic z9.
       01 detail-counts-r.
           05 filler                           pic x(28)
               value "Total number of R records: ".
           05 ws-line-r-cnt                    pic z9.
       01 details-ammount-sl.
           05 filler                           pic x(33)
               value "Total ammount of S&L records: ".
           05 ws-line-sl-amt                   pic zzzzzz9.99.
       01 detail-ammount-s.
           05 filler                           pic x(28)
               value "Total ammount of S records: ".
           05 ws-line-s-amt                    pic zzzzzz9.99.
       01 detail-ammount-l.
           05 filler                           pic x(28)
               value "Total ammount of L records: ".
           05 ws-line-l-amt                    pic zzzzzz9.99.
       01 detail-ammount-r.
           05 filler                           pic x(28)
               value "Total ammount of R records: ".
           05 ws-line-r-amt                    pic zzzzzz9.99.

       procedure division.
       000-main.
           open input valid-file.
           open output s-file.
           open output r-file.
           open output counts-file.
           read valid-file at end move 'y' to ws-eof-flag.
           perform 500-process-lines  UNTIL ws-eof-flag EQUALS "y".
           perform write-totals.
           perform write-amounts.
           perform 800-close-files.
           goback.
       500-process-lines.

           PERFORM 600-check-trans-code.
           read valid-file at end move 'y' to ws-eof-flag.
       600-check-trans-code.
           IF (valid-file-transaction-code EQUALS "R")
               THEN PERFORM 750-write-r-file
                    ADD 1 to ws-counts-total-r
                    ADD valid-file-tran-ammount to ws-amounts-total-r
           ELSE IF (valid-file-transaction-code EQUALS "L")
               PERFORM 700-write-s-file
               ADD 1 to ws-counts-total-l
               ADD valid-file-tran-ammount to ws-amounts-total-l
           ELSE IF (valid-file-transaction-code EQUALS "S")
               PERFORM 700-write-s-file
               ADD 1 to ws-counts-total-s
               ADD valid-file-tran-ammount to ws-amounts-total-s

           END-IF
           END-IF
           END-IF.



       700-write-s-file.

           write s-line from valid-line.

       750-write-r-file.
           write r-line from valid-line.
       write-totals.
           MOVE ws-counts-total-s to ws-line-s-cnt.
           MOVE ws-counts-total-r to ws-line-r-cnt.
           MOVE ws-counts-total-l to ws-line-l-cnt.
           ADD ws-counts-total-s to ws-counts-total-l
           GIVING ws-counts-total-sl.
           MOVE ws-counts-total-sl to ws-line-sl-cnt.
           WRITE counts-line from details-counts-sl.
           WRITE counts-line from detail-counts-s.
           WRITE counts-line from detail-counts-l
           WRITE counts-line from detail-counts-r.
       write-amounts.

           MOVE ws-amounts-total-s  to ws-line-s-amt.
           MOVE ws-amounts-total-l  to ws-line-l-amt.
           MOVE ws-amounts-total-r to  ws-line-r-amt.
           ADD ws-amounts-total-s to ws-amounts-total-l GIVING
               ws-amounts-total-sl.
           MOVE ws-amounts-total-sl to ws-line-sl-amt.
           WRITE counts-line from details-ammount-sl.
           WRITE counts-line from detail-ammount-s.
           WRITE counts-line from detail-ammount-l.
           WRITE counts-line from detail-ammount-r.
       800-close-files.
           close valid-file,
                 r-file,
                 s-file,
                 counts-file.

       end program SplitAndCount.
