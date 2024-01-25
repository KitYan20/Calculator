	.intel_syntax noprefix
	.text
	.global upper_func
upper_func:
	xor r10,r10 #setting r10 register value to 0
	xor r8, r8 #setting r8 regsiter value to 0 this is our counter i 
	push rax #pushes stores the previous value of rax 
	mov r10, QWORD PTR [rbx] #moves the quad value of rbx to r10
loop_start:
	mov al, BYTE PTR [r10+r8] #moves one character of a string to an al register
	
	cmp al, 0 #comparing the character values. If the last byte is 0, its the end of the string
	
	je loop_end #will jump to loop_end
	
	cmp al, 'a' #compare the character in al to the ascii value of a
	
	jb next #jump to next if the character value in al is below the ascii value of a
	
	cmp al, 'z' #compare the character in al to the ascii value of z
	
	ja next #jump to next if the character value in al is above the ascii value of z
	
	sub al, 0x20 #we subtract by 0x20 to get the uppercase letter of the lowercase
	
	mov BYTE PTR [r10+r8], al #move the upper case letter character back to it's original position
next:
	inc r8 #increment i by 1 to get the next character in the string i = i + 1
	
	jmp loop_start #the loop begins again
loop_end:
	pop rax #we have to keep the final value of rax, we need to pop rax everytime because rax value is getting changed and in the end, we still need to keep the final value of rax which is 14
	
	add rax, r8 #adds the counter which is the length of the string to the rax register
	
	ret #return back to lower_upper 
