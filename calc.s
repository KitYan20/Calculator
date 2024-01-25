	.intel_syntax noprefix #set assembly format to intel
	.data #where data can be stored in memory
final_value: #the value of rax after all the commands have run
	.quad 0 #8 bytes of 0
end: #the memory between CALC_DATA_END and CALC_DATA_BEGIN
	.quad 0 #8 bytes of 0
	.text #where we write out instructions for the source file
	.global _start #a directive linker for the location of where our instructions are located in memory
_start:
	xor rax, rax #set rax register 0
	mov rbx, OFFSET[CALC_DATA_BEGIN] # move the memory address of CALC_DATA_BEGIN for rbx to hold
loop_start:
	cmp QWORD PTR [rbx], 0 #compare if the quad value equals to  0
	je loop_done #jumps to syscall to hand control back to the OS
	
	cmp BYTE PTR [rbx], '|' #Compares the Byte value of rbx to |
	je or_func #jump to or_func label if the condition satsisfies
	
	cmp BYTE PTR [rbx], '&' #Compares the Byte value of rbx to &
	je and_func #jump to and_func label if the condition satsisfies

	cmp BYTE PTR [rbx], 'S' #Compares the Byte value of rbx to S
	je sum_func #jump to sum_func label if the condition satsisfies

	cmp BYTE PTR [rbx], 'U' #Compares the Byte value of rbx to U
	je lower_upper_func #jump to lower_upper label if the condition satsisfies

	cmp BYTE PTR [rbx], 'a' #Compares the Byte value of rbx to a
	je arraysum_func #jump to arraysum_func label if the condition satisfies

	cmp BYTE PTR [rbx], 'l' #Compares the Byte of value of rbx to l
	je listsum_func #jump to listsum_func label if the condition satisfies

	cmp BYTE PTR [rbx] , 'I' #compares the Byte value of rbx to the ascii value of 'I'
	je atoq_func

	cmp BYTE PTR [rbx], 'A' #Compares the Byte value of rbx to the ascii value of 'A'
	je array_func #jump to array_func if the condition satisfies 

	cmp BYTE PTR [rbx], 'L' #Compares the Byte value of rbx to the ascii value of 'L'
	je list_func #jump to list_func if the condition satisfies
	
	add rbx,8 #adding 8 bytes to rbx to point to the quad value
	jmp loop_start #looping back to loop_start to examine the next value in the commands 
or_func:
	add rbx, 8 #adding 8 bytes to rbx to point to the quad value
	call func_or #calling our function in or.s
	jmp loop_start #looping back to loop_start to examine the next value in the commands
	
and_func:
	add rbx, 8 #adding 8 bytes to rbx to point to the quad value
	call func_and #calling our function in and.s
	jmp loop_start #looping back to loop_start to examine the next value in the commands
	
sum_func:
	add rbx, 8 #adding 8 bytes to rbx to point to the quad value
	call func_sum #calling our function in sum.s
	jmp loop_start #looping back to loop_start to examine the next value in the commands

lower_upper_func:
	add rbx, 8 #adding 8 bytes to rbx to point to the quad value
	call upper_func #calling our function in upper.s to conver the string to uppercase and add the length of the string
	jmp loop_start #looping back to loop_start to examine the next value in the commands
arraysum_func:
	add rbx, 8 #adding 8 bytes to rbx to point to the quad value
	call arrsum_func #calling our function in arrsum.s to calculate the sum
	jmp loop_start #looping back to loop_start to examine the next value in the commands
listsum_func:
	add rbx, 8 #adding 8 bytes to rbx of the memory address get the quad value
	call lsum_func #calling our function in listsum.s based on the command l
	jmp loop_start #looping back to loop_start to examine the next value in the commands
atoq_func:
	add rbx, 8 #adding 8 bytes to rbx of the memory address get the quad value
	call atq_func #calling our function in atoq.s to support our I command
	jmp loop_start #looping back to loop_start to examine the next value in the commands
array_func:
	inc rbx #increment one byte in rbx to examine the next command '&,|,S,U' after it's main command
	call arrayf #calling our function in array.s to support our A command
	jmp loop_start #looping back to loop_start to examine the next value in the commands
list_func:
	inc rbx #increment one byte in rbx to examine the next command '&,|,S,U' after it's main command
	call listf #calling our function in list.s to support our A command
	jmp loop_start #looping back to loop_start to examine the next value in the commands
loop_done:

	add QWORD PTR [final_value], rax #add the value stored in rax to a QWORD PTR in final_value 
	mov rax, 1 #system call for write 
	mov rdi, 1 #file descriptor to output to stdout stream
	mov rsi, OFFSET [final_value] #the memory address of final_value to output data
	mov rdx, 8 #output 8 bytes to standard output
	syscall #allow the OS to write to stdout
	
	#Output the final value of SUM_POSITIVE to stdout
	mov rax, 1 #system call for write
	mov rdi ,1 #file descriptor to output to stdout stream
	mov rsi, OFFSET [SUM_POSITIVE] #the memory address of SUM_POSITIVE to output data
	mov rdx, 8 #output 8 bytes of data from the memory address of SUM_POSITIVE 
	syscall #allow the OS to write to stdout
	
	#Output the final value of SUM_NEGATIVE to stdout
	mov rax, 1 #system call for write
	mov rdi, 1 #file descriptor to output to stdout stream
	mov rsi, OFFSET [SUM_NEGATIVE] #the memory address of SUM_NEGATIVE to data
	mov rdx, 8 #output 8 bytes to standard output
	syscall #allow the OS to write to stdout

	#Output the memory between CALC_DATA_BEGIN and CALC_DATA_END
	xor rcx, rcx #set rcx register to 0
	mov rcx, OFFSET [CALC_DATA_END] #rcx holds the memory address of CALC_DATA_END
	add QWORD PTR [end], rcx #store the value of rcx to a QWORD PTR
	xor r9, r9 #set r9 register to 0
	mov r9, OFFSET [CALC_DATA_BEGIN] #r9 holds the memory address of CALC_DATA_END
	sub QWORD PTR [end], r9 #subtract the amount of data between CALC_DATA END to CALC_DATA_BEGIN

	mov rax, 1 #system call for write
	mov rdi, 1 #file descriptor to output to stdout stream
	mov rsi, OFFSET [CALC_DATA_BEGIN] #the memory address of CALC_DATA_BEGIN to get the data from 
	mov rdx, QWORD PTR [end] #The amount of bytes we want to output the data from the memory address
	syscall #allow the OS to write to stdout
	mov rax, 60 #system call for exit
	mov rdi, 0 #return the exit code as 0 to indicate no error
	syscall #hands control back to the os
