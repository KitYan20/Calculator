	.intel_syntax noprefix
	.text
	.global lsum_func
lsum_func:
	xor r9, r9 #set register value inside to 0 will be used to hold our quad values
	xor r11, r11 #set register value inside to 0 will be used to hold our final sum in rax
	push rax #pushes a stack to allow rax to temporaily hold some values
	mov r9, QWORD PTR [rbx] #points to the memory address of head node located in the quad value
loop_start:
	cmp r9, 0 #compares if the quad value in r9 is equal to 0
	je loop_end #jump to the end of the loop if the quad value is 0
	mov rbx, r9 #move the quad value in r9 to rbx to be used for func_sum function
	add r9, 8 #increment 8 bytes in r9 to move to the next quad value
	call func_sum #calling our sum function to sum the elements
	mov r9, QWORD PTR [r9] #gets the next Node of the memory address that points to the next quad element from that memory address in the list
	jmp loop_start #repeat the process again until it finds a quad element = 0
loop_end:
	mov r11, rax #move the final sum in rax to an open r11 register 
	pop rax #pop the temporary value of rax to let rax get back it's previous value
	add rax, r11 #add the sum  back to rax for stdout
	ret #return back to the previous location of where we called the function from calc.s to continue with the process
