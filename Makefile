.SILENT: clean

dummy: dummy.o
	ld -g dummy.o data/basic_cmds.o -o dummy
dummy.o: dummy.s
	as -g dummy.s -o dummy.o
calc.o: calc.s
	as -g calc.s -o calc.o
calc_basic: data/basic_cmds.o list.o array.o atoq.o listsum.o arrsum.o upper.o calc.o sum.o and.o or.o
	ld -g $^ -o $@
calc_upperonly: data/upperonly_cmds.o list.o array.o atoq.o listsum.o arrsum.o upper.o calc.o sum.o and.o or.o
	ld -g $^ -o $@
calc_simpleone: data/simpleone_cmds.o list.o array.o atoq.o listsum.o arrsum.o upper.o calc.o sum.o and.o or.o
	ld -g $^ -o $@
calc_easy: data/easy_cmds.o list.o array.o atoq.o listsum.o arrsum.o upper.o calc.o sum.o and.o or.o
	ld -g $^ -o $@
calc_basicwithupper: data/basicwithupper_cmds.o list.o array.o atoq.o listsum.o arrsum.o upper.o calc.o sum.o and.o or.o
	ld -g $^ -o $@
calc_simplerandom: data/simplerandom_cmds.o list.o array.o atoq.o listsum.o arrsum.o upper.o calc.o sum.o and.o or.o
	ld -g $^ -o $@
calc_arraysum: data/arraysum_cmds.o list.o array.o atoq.o listsum.o arrsum.o upper.o calc.o sum.o and.o or.o
	ld -g $^ -o $@
calc_listsum: data/listsum_cmds.o list.o array.o atoq.o listsum.o arrsum.o upper.o calc.o sum.o and.o or.o
	ld -g $^ -o $@
calc_atoq: data/atoq_cmds.o list.o array.o atoq.o listsum.o arrsum.o upper.o calc.o sum.o and.o or.o
	ld -g $^ -o $@
calc_array: data/array_cmds.o list.o array.o atoq.o listsum.o arrsum.o upper.o calc.o sum.o and.o or.o
	ld -g $^ -o $@
calc_list: data/list_cmds.o list.o array.o atoq.o listsum.o arrsum.o upper.o calc.o sum.o and.o or.o
	ld -g $^ -o $@
and.o: and.s
	as -g and.s -o and.o
or.o: or.s
	as -g or.s -o or.o
sum.o: sum.s
	as -g sum.s -o sum.o
upper.o: upper.s
	as -g upper.s -o upper.o
arrsum.o: arrsum.s
	as -g arrsum.s -o arrsum.o
listsum.o: listsum.s
	as -g listsum.s -o listsum.o
atoq.o: atoq.s
	as -g atoq.s -o atoq.o
array.o: array.s
	as -g array.s -o array.o
list.o: list.s
	as -g list.s -o list.o
data/basic_cmds.o: data/basic_cmds.s
	as -g data/basic_cmds.s -o  data/basic_cmds.o
data/simpleone_cmds.o: data/simpleone_cmds.s
	as -g data/simpleone_cmds.s -o data/simpleone_cmds.o
data/upperonly_cmds.o: data/upperonly_cmds.s
	as -g data/upperonly_cmds.s -o data/upperonly_cmds.o
data/easy_cmds.o: data/easy_cmds.s
	as -g data/easy_cmds.s -o data/easy_cmds.o
data/basicwithupper_cmds.o: data/basicwithupper_cmds.s
	as -g data/basicwithupper_cmds.s -o data/basicwithupper_cmds.o
data/simplerandom_cmds.o: data/simplerandom_cmds.s
	as -g data/simplerandom_cmds.s -o data/simplerandom_cmds.o
data/arraysum_cmds.o: data/arraysum_cmds.s
	as -g data/arraysum_cmds.s -o data/arraysum_cmds.o
data/listsum_cmds.o: data/listsum_cmds.s
	as -g data/listsum_cmds.s -o data/listsum_cmds.o
data/atoq_cmds.o: data/atoq_cmds.s
	as -g data/atoq_cmds.s -o data/atoq_cmds.o
data/array_cmds.o: data/array_cmds.s
	as -g data/array_cmds.s -o data/array_cmds.o
data/list_cmds.o: data/list_cmds.s
	as -g data/list_cmds.s -o data/list_cmds.o
clean:
	rm -f *.o
	rm -f dummy calc_basic calc_upperonly calc_simpleone calc_easy calc_basicwithupper calc_simplerandom calc_arraysum
	rm -f calc_listsum calc_atoq calc_array calc_list
