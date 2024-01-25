	.intel_syntax noprefix #set assembly format to intel
	.section .text #where we write our instructions for the or.s file
	.global func_or #allow global access for the function to be called
func_or:
	#rax right now holds the value of 0 because of the xor logic making it only one value can be true and xor rax,rax is the same value which would make it false.
	#rbx holds the memory address of data_start
	or rax, QWORD PTR [rbx] 
	add rbx, 8 #Increments 8 bytes to the next piece of data in rbx
	ret #transfers control to the return address
