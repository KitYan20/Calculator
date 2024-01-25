	.intel_syntax noprefix #set assembly format to intel
	.section .data #place to store data in SUM_POSITIVE and SUM_NEGATIVE into memory
SUM_POSITIVE:
	.quad 0 #8 bytes of zero
SUM_NEGATIVE:
	.quad 0 #8 bytes of zero

	.global SUM_POSITIVE #will allow the reference SUM_POSITIVE to be accessed globally
	.global SUM_NEGATIVE #will allow the reference SUM_NEGATIVE to be accessed globally
	.section .text #where we write out instructions for the source file
	.global func_sum #a directive linker for sumtest to access our instructions

func_sum:	
	add rax, QWORD PTR[rbx] #rbx = y and rax = x

	cmp  QWORD PTR [rbx],0 #checks the eflags when subtracting the value of rbx to 0. Will set eflags as SF if (result is negative)

	jge Positive  #jump into the  Positive Label if QWORD PTR [rbx] >= 0

	jl Negative #jump into the Negative Label if QWORD PTR [rbx] < 0

Positive:
	mov rdx, QWORD PTR [rbx] #move the value of rbx to an open rdx register
	add QWORD PTR [SUM_POSITIVE], rdx #add the value located in rdx to a quad pointer in SUM_POSITIVE
	jmp done

Negative:
	mov rdx, QWORD PTR [rbx] #move the value of rbx to an open rdx register
	add QWORD PTR [SUM_NEGATIVE], rdx #add the value located in rdx to a quad pointer in SUM_NEGATIVE
	jmp done
done:
	add rbx, 8 #increment 8 bytes to the next piece of data in rbx
	ret
