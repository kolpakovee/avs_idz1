	.file	"main.c"
	.intel_syntax noprefix
	.text
	.data
	.align 4
	.type	maxLength, @object
	.size	maxLength, 4
maxLength:                      #переменная, определяющая максимальное число элементов в массиве
	.long	1000                #значение перемнной maxLength
	.local	arrayA              #массив, в который считываются данные
	.comm	arrayA,4000,32      #выделение памяти 4000 байт (1000 * sizeof(int))
	.local	arrayB              #массив, в который будет записан результат
	.comm	arrayB,4000,32      #выделение памяти 4000 байт
	.section	.rodata
.LC0:
	.string	"Enter %d value: "  #строка, которая говорит пользователю ввести данные
.LC1:
	.string	"%d"                #строка, для формата ввода
	.text
	.globl	getArrayA           #объявление функции
	.type	getArrayA, @function
getArrayA:                      #функция заполнения массива
	endbr64
	push	rbp                 сохранение rbp на стек
	mov	rbp, rsp                rbp := rsp
	sub	rsp, 32                 вычитаем из rsp 32
	mov	DWORD PTR -20[rbp], edi указывает где на стеке разместить первый аргумент функции (переменная sizeA)
	mov	DWORD PTR -4[rbp], 0    счётчик цикла (переменная i)
	jmp	.L2                     перемещение к L2
.L3:                                тело цикла
	mov	eax, DWORD PTR -4[rbp]      eax := переменная цикла
	add	eax, 1                      добавляем 1 к eax для вывода в printf
	mov	esi, eax                    esi := eax
	lea	rax, .LC0[rip]              загружает адрес строки LC0 (описана выше) в rax
	mov	rdi, rax                    rdi := rax
	mov	eax, 0                      ввод целых чисел
	call	printf@PLT              вызов функции printf
	lea	rax, -8[rbp]                rax := адрес вводимой переменной (адрес локальной переменной)
	mov	rsi, rax
	lea	rax, .LC1[rip]              подсказка для ввода
	mov	rdi, rax
	mov	eax, 0                      ввод целых чисел
	call	__isoc99_scanf@PLT      вызов функции scanf
	mov	eax, DWORD PTR -8[rbp]      eax := адрес в стеке на введённое значение
	mov	edx, DWORD PTR -4[rbp]      edx := адрес счётчика
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]             rcx := адрес i-го элемента массива
	lea	rdx, arrayA[rip]
	mov	DWORD PTR [rcx+rdx], eax    присваиваем i-му элементу массива введённое значение
	add	DWORD PTR -4[rbp], 1        увеличение сётчика на 1
.L2:                                цикл for
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -20[rbp]     сравнение eax и sizeA (аргумент функции)
	jl	.L3                         если eax < sizeA переходим в .L3
	nop
	nop
	leave                           очистка стека
	ret                             взоврат в вызывающую функцию
	.size	getArrayA, .-getArrayA  объявление функции
	.globl	getArrayB
	.type	getArrayB, @function
getArrayB:
	endbr64
	push	rbp                     сохраняем rbp на стек
	mov	rbp, rsp                    rbp := rsp
	mov	DWORD PTR -20[rbp], edi     указывает где на стеке разместить первый аргумент функции (переменная sizeA)
	mov	DWORD PTR -4[rbp], 0        счётчик цикла (переменная i)
	jmp	.L5                         перемещение в .L5
.L6:                                тело цикла
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, arrayA[rip]
	mov	edx, DWORD PTR [rdx+rax]
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rcx, 0[0+rax*4]
	lea	rax, arrayA[rip]
	mov	eax, DWORD PTR [rcx+rax]
	imul	eax, edx
	mov	edx, DWORD PTR -4[rbp]
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]
	lea	rdx, arrayB[rip]
	mov	DWORD PTR [rcx+rdx], eax
	add	DWORD PTR -4[rbp], 1
.L5:                                цикл for
	mov	eax, DWORD PTR -4[rbp]      eax := адрес счётчика (i)
	cmp	eax, DWORD PTR -20[rbp]     сравнение счётчика c sizeA (аргумент функции)
	jl	.L6                         если eax < sizeA переходим в .L6
	nop
	nop
	pop	rbp                         очистка стека в исходное состояние
	ret                             возврат в вызывающую функцию
	.size	getArrayB, .-getArrayB
	.section	.rodata
.LC2:
	.string	"Array B: "
.LC3:
	.string	"%d "
	.text
	.globl	outResult
	.type	outResult, @function
outResult:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	DWORD PTR -20[rbp], edi
	lea	rax, .LC2[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	DWORD PTR -4[rbp], 0
	jmp	.L8
.L9:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, arrayB[rip]
	mov	eax, DWORD PTR [rdx+rax]
	mov	esi, eax
	lea	rax, .LC3[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	add	DWORD PTR -4[rbp], 1
.L8:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jl	.L9
	nop
	nop
	leave
	ret
	.size	outResult, .-outResult
	.section	.rodata
.LC4:
	.string	"Enter length: "
	.align 8
.LC5:
	.string	"You entered an invalid number."
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	lea	rax, .LC4[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	lea	rax, -4[rbp]
	mov	rsi, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	mov	edx, DWORD PTR -4[rbp]
	mov	eax, DWORD PTR maxLength[rip]
	cmp	edx, eax
	jle	.L11
	lea	rax, .LC5[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L13
.L11:
	mov	eax, DWORD PTR -4[rbp]
	mov	edi, eax
	call	getArrayA
	mov	eax, DWORD PTR -4[rbp]
	mov	edi, eax
	call	getArrayB
	mov	eax, DWORD PTR -4[rbp]
	mov	edi, eax
	call	outResult
	mov	eax, 0
.L13:
	leave
	ret