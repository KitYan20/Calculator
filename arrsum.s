	.intel_syntax noprefix
	.text
	.global arrsum_func
arrsum_func:
	xor r12, r12 #set register value to 0 holds the length of the array i = length
	xor r13, r13 #set register value to 0 to hold the 8-byte address to an array of 8-byte values
	xor rdx,rdx #set register value to 0 and hold the sum of all the quad values
	push rax #pushes a stack to allow rax to temporaily hold some values
	mov r12 , QWORD PTR [rbx] #move the length argument of the array to register r12
	add rbx, 8 #increment 8 bytes to rbx to get the next 8 byte argument which is an 8 byte address to an array of 8 byte values
	mov r13, QWORD PTR [rbx] #move the address of the array of byte values to register r13 
loop_start:
	cmp r12, 0 #will check if the length of the array is 0 
	je loop_end #jump to the end of the loop if the length is 0 indicating that there are no more values to calculate
	mov rbx, r13 #move one 8 byte address to rbx
	add r13, 8 #increment register r13 8 bytes to get the next address of the 8 byte to sum
	call func_sum #our sum function will add up the value of rbx by using the QWORD PTR to get the actual numerical value in the quad instead of it's memory address
	dec r12 #decrement the length by 1 indicating one value has been added -> i = i - 1
	jmp loop_start #repeat the process again until the length reaches 0
loop_end:
	mov rdx, rax #move the sum value located in rax to rdx
	pop rax #pop the temporary value of rax to let rax get back it's previous value
	add rax, rdx #add the final sum back to rax for stdout
	ret #return back to the previous location of where we called the function from calc.s to continue with the process


	
