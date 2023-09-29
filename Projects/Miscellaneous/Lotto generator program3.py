import sys
import random
from random import randint

onenumbers = [1, 11, 21, 31, 41]
twonumbers = [2, 12, 22, 32, 42]
threenumbers = [3, 13, 23, 33, 43]
fournumbers = [4, 14, 24, 34, 44]
fivenumbers = [5, 15, 25, 35, 45]
sixnumbers = [6, 16, 26, 36, 46]
sevennumbers = [7, 17, 27, 37, 47]
eightnumbers = [8, 18, 28, 38, 48]
ninenumbers = [9, 19, 29, 39, 49]
zeronumbers = [10, 20, 30, 40, 50]

selectednumbers = []
oddoreven = int

#This program will choose numbers based on the digit 1-10
frequency = input("Enter the numbers you want to play: ")
try:
    frequency = int(frequency)

    rows = input("Enter the number of rows: ")
    try:
        rows = int(rows)
        rowcount = int

        rowcount = 1
        x = int
        while rowcount <= rows:
            
            x = 1
            while x <= frequency:
                oddoreven = random.randint(0, 10)
                if oddoreven == 1:
                    #generate a random odd number
                    chance = random.randint(0, len(onenumbers) - 1)
                    selectednumbers.append(onenumbers[chance])
                    onenumbers.remove(onenumbers[chance])
                elif oddoreven == 2:
                    chance = random.randint(0, len(twonumbers) - 1)
                    selectednumbers.append(twonumbers[chance])
                    twonumbers.remove(twonumbers[chance])
                elif oddoreven == 3:
                    chance = random.randint(0, len(threenumbers) - 1)
                    selectednumbers.append(threenumbers[chance])
                    threenumbers.remove(threenumbers[chance])
                         
                elif oddoreven == 4:
                    chance = random.randint(0, len(fournumbers) - 1)
                    selectednumbers.append(fournumbers[chance])
                    fournumbers.remove(fournumbers[chance])
                elif oddoreven == 5:
                    chance = random.randint(0, len(fivenumbers) - 1)
                    selectednumbers.append(fivenumbers[chance])
                    fivenumbers.remove(fivenumbers[chance])
                elif oddoreven == 6:
                    chance = random.randint(0, len(sixnumbers) - 1)
                    selectednumbers.append(sixnumbers[chance])
                    sixnumbers.remove(sixnumbers[chance])
                elif oddoreven == 7:
                    chance = random.randint(0, len(sevennumbers) - 1)
                    selectednumbers.append(sevennumbers[chance])
                    sevennumbers.remove(sevennumbers[chance])
                elif oddoreven == 8:
                    chance = random.randint(0, len(eightnumbers) - 1)
                    selectednumbers.append(eightnumbers[chance])
                    eightnumbers.remove(eightnumbers[chance])
                elif oddoreven == 9:
                    chance = random.randint(0, len(ninenumbers) - 1)
                    selectednumbers.append(ninenumbers[chance])
                    ninenumbers.remove(ninenumbers[chance])
                elif oddoreven == 10:
                    chance = random.randint(0, len(zeronumbers) - 1)
                    selectednumbers.append(zeronumbers[chance])
                    zeronumbers.remove(zeronumbers[chance])
                x = x+1
            selectednumbers.sort()
            print("Row", rowcount, ": ", selectednumbers)


            selectednumbers.clear()
            #clear everything after printing out the numbers

            onenumbers.clear()
            twonumbers.clear()
            threenumbers.clear()
            fournumbers.clear()
            fivenumbers.clear()
            sixnumbers.clear()
            sevennumbers.clear()
            eightnumbers.clear()
            ninenumbers.clear()
            zeronumbers.clear()
            #same goes for the numbers

            z = int
            z = 1
            while z <= 50:
                #reset the list
                if z == 1 or z == 11 or z == 21 or z == 31 or z == 41:
                    onenumbers.append(z)
                elif z == 2 or z == 12 or z == 22 or z == 32 or z == 42:
                    twonumbers.append(z)
                elif z == 3 or z == 13 or z == 23 or z == 33 or z == 43:
                    threenumbers.append(z)
                elif z == 4 or z == 14 or z == 24 or z == 34 or z == 44:
                    fournumbers.append(z)
                elif z == 5 or z == 15 or z == 25 or z == 35 or z == 45:
                    fivenumbers.append(z)
                elif z == 6 or z == 16 or z == 26 or z == 36 or z == 46:
                    sixnumbers.append(z)
                elif z == 7 or z == 17 or z == 27 or z == 37 or z == 47:
                    sevennumbers.append(z)
                elif z == 8 or z == 18 or z == 28 or z == 38 or z == 48:
                    eightnumbers.append(z)
                elif z == 9 or z == 19 or z == 29 or z == 39 or z == 49:
                    ninenumbers.append(z)
                elif z == 10 or z == 20 or z == 30 or z == 40 or z == 50:
                    zeronumbers.append(z)
                z = z + 1


            rowcount = rowcount + 1

        print("")
        print("Good luck tonight!")
    except:
        print("Not a valid input")
        sys.exit()
except:
    print("Not a valid input")
    sys.exit()




