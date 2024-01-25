	.intel_syntax noprefix
	.text
	.global arrayf
arrayf:
	xor r9,r9 #set register value to 0. This will the memory address of the array
	xor r8,r8 #set register value to 0. This will hold the length of the array
	push rax #push the stack to to maintain previous values in rax
loop_start:
	cmp QWORD PTR [rbx], 0 #compares the quad value to 0 to indicate the end of the loop
	je loop_end #if the quad value is 0, we jump to the end of the loop
	
	cmp BYTE PTR [rbx], '&' #Compares the next byte command to '&' after 'A' command
	je ands #jump to ands label to start supporting for & command
	
	cmp BYTE PTR [rbx], '|' #Compares the next byte command to '|' after 'A' command
	je ors #jump to ors label to start supporting for & command

	cmp BYTE PTR [rbx], 'S' #Compares the next byte command to 'S' after 'A' command
	je sums #jump to sums label to start supporting for & command

	cmp BYTE PTR [rbx], 'U' #Compares the next byte command to 'U' after 'A' command
	je uppers #jump to uppers label to start supporting for & command

	add rbx, 8 
	#Below is where it will examine the other basic commands depending what command it is
ands:
	add rbx, 7 #add rbx 7 to get the length of the array
	mov r8, QWORD PTR [rbx] #move the length of the array to register r8
	add rbx, 8 #increment rbx 8 bytes to get the address of the array of quad values
	mov r9, QWORD PTR [rbx] #move the memory address of the array to register r9
	jmp andf #jmp to andf to start looping the values in the array for the & command 
andf:
	cmp r8,0 #compares the length of the array to 0
	je loop_end #jump to the end of the loop if it's end of the loop meaning all the values are examined
	mov rbx, r9 #move the address of each integer value located in that memory address
	call func_and #call our helper function for & command
	add r9, 8 #increment 8 bytes to the memory address to get the next quad value
	dec r8 #decrement the length by one 
	jmp andf #loop back to repeat the process until all quad values are examined
ors:
	add rbx, 7 #add rbx 7 to get the length of the array
	mov r8, QWORD PTR [rbx] #move the length of the array to register r8
	add rbx, 8 #increment rbx 8 bytes to get the address of the array of quad values
	mov r9, QWORD PTR [rbx] #move the memory address of the array to register r9
	jmp orf #jmp to orf start looping the values in the array for the | command
orf:
	cmp r8, 0 #move the address of each integer value located in that memory address
	je loop_end #jump to the end of the loop if it's end of the loop meaning all the values are examined
	mov rbx, r9 #move the address of each integer value located in that memory address
	call func_or #call our helper function for | command
	add r9, 8 #move the memory address of the array to register r9
	dec r8 #decrement the length by one
	jmp orf #loop back to repeat the process until all quad values are examined
sums:
	add rbx, 7 #add rbx 7 to get the length of the array
	mov r8, QWORD PTR [rbx] #move the length of the array to register r8
	add rbx, 8 #increment rbx 8 bytes to get the address of the array of quad values
	mov r9, QWORD PTR [rbx] #move the memory address of the array to register r9
	jmp sumf #jmp to andf to start looping the values in the array for the S command
sumf:
	cmp r8, 0 #move the address of each integer value located in that memory address
	je loop_end #jump to the end of the loop if it's end of the loop meaning all the values are examined
	mov rbx, r9 #move the address of each integer value located in that memory address
	call func_sum #call our helper function for S command
	add r9, 8 #move the memory address of the array to register r9
	dec r8 #decrement the length by one
	jmp sumf #loop back to repeat the process until all quad values are examined
uppers:
	add rbx, 7 #add rbx 7 to get the length of the array 
	mov r8, QWORD PTR [rbx] #move the length of the array to register r8
	add rbx, 8 #increment rbx 8 bytes to get the address of the array of quad values
	mov r9, QWORD PTR [rbx] #move the memory address of the array to register r9
	jmp upperf #jmp to andf to start looping the values in the array for the U command
upperf:
	cmp r8, 0 #move the address of each integer value located in that memory address
	je loop_end #jump to the end of the loop if it's end of the loop meaning all the values are examined
	mov rbx, r9 #move the address of each integer value located in that memory address
	call upper_func #call our helper function for U command
	add r9, 8 #move the memory address of the array to register r9
	dec r8 #decrement the length by one
	jmp upperf #loop back to repeat the process until all quad values are examined
loop_end:	
	mov rdx, rax #move the final value of rax to rdx
	pop rax #pop it out of the stack to return previous value held
	mov rax, rdx #mov the final value back to rax
	ret #return back to the location of where we called arrayf
