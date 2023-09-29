/*
 * Ethan Chen
 * OOP 3200
 * November 2, 2022
 * Mohammad Shamas
 */

//This is the first ICE that is done for Java. Although I remember working with Java in high school, I may not remember
//what was taught, so I need a refresher.

import java.util.*;

public class Practice {
	public static void main(String[] args)
	{
		System.out.println("Hello world!");
		System.out.println("Welcome to Java!");
		
		Scanner sc = new Scanner(System.in);
		System.out.print("Give me a decimal integer:");
		float a = sc.nextFloat();
		float b = a;
		
		System.out.println("We have read your value");
		System.out.print("Your value is " + b);
	}
}
