pizzadiam = int
pizzarad = str
area = int

pizzadiam = input("Please enter the diameter of your pizza: ")

pizzadiam = int(pizzadiam)

pizzarad = pizzadiam/2 # find the radius


if pizzadiam < 12:
    print("A diameter of less than 12 inches can cut in 6 slices.")
    area = 3.14 * pizzarad**2 #calculate the area of the pizza after splitting the diameter in half
    print("The area of a ", pizzarad, "inch pizza is ", area, "in².")
    print("Each slide will be worth", round(pizzadiam/6, 2), " inches") #this will show the length of a pizza
    print("Every slice will measure an angle of ", 360/6, "°")
elif pizzadiam > 12 and pizzadiam < 14:
    print("A diameter of 12 inches up to less than 14 inches can cut in 8 slices.")
    area = 3.14 * pizzarad**2
    print("The area of a ", pizzarad, "inch pizza is ", area, "in².")
    print("Each slide will be worth", round(pizzadiam/8, 2), " inches")
    print("Every slice will measure an angle of ", 360/8, "°")
elif pizzadiam > 14 and pizzadiam < 16:
    print("A diameter of 14 inches up to less than 16 inches can cut in 10 slices.")
    area = 3.14 * pizzarad**2
    print("The area of a ", pizzarad, "inch pizza is ", area, "in².")
    print("Each slide will be worth", round(pizzadiam/10, 2), " inches")
    print("Every slice will measure an angle of ", 360/10, "°")
elif pizzadiam > 16 and pizzadiam < 20:
    print("A diameter of 16 inches up to less than 20 inches can cut in 12 slices.")
    area = 3.14 * pizzarad**2
    print("The area of a ", pizzarad, "inch pizza is ", area, "in².")
    print("Each slide will be worth", round(pizzadiam/12, 2), " inches")
    print("Every slice will measure an angle of ", 360/12, "°")
else:
    print("A diameter of over 20 inches can cut in 16 slices.")
    area = 3.14 * pizzarad**2
    print("The area of a ", pizzarad, "inch pizza is ", area, "in².")
    print("Each slide will be worth", round(pizzadiam/16, 2), " inches")
    print("Every slice will measure an angle of ", 360/12, "°")

input("Press ENTER to exit... ")