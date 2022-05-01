#!/bin/bash

input_function(){
	while true
	do
		echo "Please enter your name: "
		read name
		# The name can't include numbers or special characters
		if ! [[ $name =~ ^[A-Za-z_]+$ ]]; then
			echo " "
			echo "----- Wrong input. The name can't include numbers or special characters. -----"
			echo " "
		else
			break
		fi
	done
	# The phone number must contain only digits and it has to be 10 digits long
	while true
	do	
		echo "Please enter your phone number: "
		read phonenumber
		digits='^[0-9]+$'
		length=${#phonenumber}
		if ! [[ $phonenumber =~ $digits ]]; then
			echo " "
			echo "----- Wrong input. Please insert only digits. -----"
			echo " "
		elif (($length != 10)); then
			echo " "
			echo "----- Wrong input. The phone number must have 10 digits. -----"
			echo " "
		else
			break
		fi
	done
	# Check if the customer inserts "single, double or kingsize". Other inputs are not accepted
	while true
	do
		echo "What kind of bed do you want? single/double/kingsize: "
		echo "Price list: single = £50        double = £100        kingsize = £150"
		read bedtype
		if [ "$bedtype" == "single" ] ||  [ "$bedtype" == "double" ] || [ "$bedtype" == "kingsize" ]; then
			break;
		else
			echo " "
			echo '----- '"$bedtype"' is a Wrong input. Plese insert "single, double or kingsize" -----'
			echo " "
		fi
	done
	# Check if the customer inserts a good value, e.g. the number of beds cannot be 0 or negative
	while true
	do
		echo "How many pieces of $bedtype beds do you want? "
		read bednumber
		if (( bednumber < 1 )); then
			echo " "
			echo "----- Wrong input. The bed numbers must be 1 or higher. Please try again. -----"
			echo " "
		else
			break
		fi
	done
}

# This function will print all the details of the order
print_function(){
	echo "-------------------------------------------------"
	echo " "
	echo "Hello $name, here is the summary of your order: "
	date	
	echo " "
	echo "Your telephone number is $phonenumber."
	# Generate the right output by checking if the customer ordered only 1 bed or more beds
	if (( bednumber > 1 )); then
		echo "You have ordered $bednumber $bedtype beds."
	else
		echo "You have ordered $bednumber $bedtype bed."
	fi
	# Calculate the total sum for each possible case, Single = £50, Double = £100, Kingsize = £150
	if [ "$bedtype" == "single" ]; then
		let totalsum = bednumber * 50
		echo "A $bedtype bed is £50, so you should pay £$totalsum."
	elif [ "$bedtype" == "double" ]; then
		let totalsum = bednumber * 100
		echo "A $bedtype bed is £100, so you should pay £$totalsum."
	elif [ "$bedtype" == "kingsize" ]; then
		let totalsum = bednumber * 150
		echo "A $bedtype bed is £150, so you should pay £$totalsum."
	fi
	echo " "
	echo "-------------------------------------------------"
	echo " "
}

# Main
while true
do
	echo "Please enter your choice: order/quit "
	read choice
	# If the customer inserts "quit" or "QUIT", the program will end
	if [ "$choice" == "quit" ] || [ "$choice" == "QUIT" ]; then
		echo " "
		echo "---------- Thank you! See you next time! ----------"
		echo " "
		break
	# The program accepts only "quit" and "order" in both upper and lower case
	elif [ "$choice" != "quit" ] && [ "$choice" != "QUIT" ] && [ "$choice" != "order" ] && [ "$choice" != "ORDER" ]; then
		echo " "
		echo "----- Sorry, $choice is not a valid choice. Please try again. ----"
		echo " "
	# When the customer inserts "order" or "ORDER", the program will call the input and print functions
	elif [ "$choice" == "order" ] || [ "$choice" == "ORDER" ]; then
		input_function 
		print_function "$name" "$phonenumber" "$bednumber" "$bedtype"
		echo "Do you want to start another order?"
	fi
done


