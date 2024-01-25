	.intel_syntax noprefix #set assembly format to intel
	.section .text #where we write our instructions for the and.s file
	.global func_and #allow global access for the function to be called
func_and:
	#rax is storing the hex value and rbx is storing the memory address data_start
	#Updates rax to hold the value of rax with bitwise and of the 8 byte quantity value at &y memory address 
	and rax, QWORD PTR [rbx] 
	add rbx, 8 #Increments 8 bytes to the next piece of data.
	ret #transfers control to the return address
