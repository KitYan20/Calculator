	.intel_syntax noprefix
	.text
	.global listf
listf:
	xor r9, r9 #set register r9 value to 0. This will be the memory address of each value for the specified node
	xor rdx, rdx
	push rax #push rax on the stack to preserve previous values
#the concept for loop_start is the same as A but using a List implementation instead
loop_start:
	cmp BYTE PTR [rbx], '&'
	je ands

	cmp BYTE PTR [rbx], '|'
	je ors

	cmp BYTE PTR [rbx], 'S'
	je sums

	cmp BYTE PTR [rbx], 'U'
	je uppers
ands:
	add rbx, 7 #add rbx 7 to get the memory address of the head node
	mov r9, QWORD PTR [rbx] #move the head node into register r9
	jmp andf #jump to andf label to starting traversing the list
andf:
	cmp r9, 0 #compares the quad value of the specified node to 0
	je loop_end #we end the loop if that's case
	mov rbx, r9 #move the address of each node into rbx 
	add r9, 8 #increment 8 bytes to get the next memory address of a node
	call func_and #call our helper function for & command
	mov r9, QWORD PTR[r9] #move the next quad value which is a memory address of the next Node to r9 
	jmp andf #jump back to andf to loop the process again
#the rest of the codes below would be the same process except for the different commands and functions it'll use 
ors:
	add rbx, 7
	mov r9, QWORD PTR [rbx]
	jmp orf
orf:
	cmp r9, 0
	je loop_end
	mov rbx, r9
	add r9,8
	call func_or
	mov r9, QWORD PTR [r9]
	jmp orf
sums:
	add rbx, 7
	mov r9, QWORD PTR [rbx]
	jmp sumf
sumf:
	cmp r9, 0
	je loop_end
	mov rbx, r9
	add r9, 8
	call func_sum
	mov r9, QWORD PTR[r9]
	jmp sumf
uppers:
	add rbx, 7
	mov r9, QWORD PTR [rbx]
upperf:
	cmp r9, 0
	je loop_end
	mov rbx, r9
	add r9,8
	call upper_func
	mov r9, QWORD PTR [r9]
	jmp upperf
loop_end:
	mov rdx, rax #move the final value of rax after examining the list
	pop rax #pop the value of rax to return the previous value held at rax
	mov rax, rdx #move the final value back to rax

