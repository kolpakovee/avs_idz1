#заменено DWORD PTR -8[rbp] -> r15d
#загрузили переменную sizeA в регистр r13d и DWORD PTR -4[rbp] -> r13d
#заменено DWORD PTR -20[rbp] -> r14d
#заменено DWORD PTR -4[rbp] -> r12d

.file    "main.c"
.intel_syntax noprefix
.text
.data
.align 4
.type    maxLength, @object
.size    maxLength, 4
maxLength:                      #переменная, определяющая максимальное число элементов в массиве
.long    1000                #значение перемнной maxLength
.local    arrayA              #массив, в который считываются данные
.comm    arrayA,4000,32      #выделение памяти 4000 байт (1000 * sizeof(int))
.local    arrayB              #массив, в который будет записан результат
.comm    arrayB,4000,32      #выделение памяти 4000 байт
.section    .rodata
.LC0:
.string    "Enter %d value: "  #строка, которая говорит пользователю ввести данные
.LC1:
.string    "%d"                #строка, для формата ввода
.text
.globl    getArrayA            #объявление функции
.type    getArrayA, @function
getArrayA:                     #функция заполнения массива
endbr64
push    rbp                 #сохранение rbp на стек
mov    rbp, rsp             #rbp := rsp
sub    rsp, 32              #вычитаем из rsp 32
mov    r14d, edi            #загрзука sizeA (аргумента функции) в регистр r14d
mov    r12d, 0              #загрузка переменной цикла в регистр r12d
jmp    .L2                  #перемещение к L2
.L3:                                #тело цикла
mov    eax, r12d                    #eax := переменная цикла, загруженная в регистр r12d
add    eax, 1                      #добавляем 1 к eax для вывода в printf
mov    esi, eax                    #esi := eax
lea    rax, .LC0[rip]              #загружает адрес строки LC0 (описана выше) в rax
mov    rdi, rax                    #rdi := rax
mov    eax, 0                      #ввод целых чисел
call    printf@PLT              #вызов функции printf
lea    rax, -8[rbp]                #rax := адрес вводимой переменной (адрес локальной переменной)
mov    rsi, rax
lea    rax, .LC1[rip]              #подсказка для ввода
mov    rdi, rax
mov    eax, 0                      #ввод целых чисел
call    __isoc99_scanf@PLT      #вызов функции scanf
mov    r15d, -8[rbp]                #загрузка переменной value в регистр r15d
mov    eax, r15d                #заменено DWORD PTR -8[rbp] -> r15d
mov    edx, r12d      #edx := адрес счётчика
movsx    rdx, edx
lea    rcx, 0[0+rdx*4]             #rcx := адрес i-го элемента массива
lea    rdx, arrayA[rip]
mov    DWORD PTR [rcx+rdx], eax    #присваиваем i-му элементу массива введённое значение
add    r12d, 1                     #увеличение сётчика на 1
.L2:                                #цикл for
mov    eax, r12d                   #eax := переменная цикла i
cmp    eax, r14d     #сравнение eax и sizeA (аргумент функции)
jl    .L3                         #если eax < sizeA переходим в .L3
nop
nop
leave                           #очистка стека
ret                             #взоврат в вызывающую функцию
.size    getArrayA, .-getArrayA  #объявление функции
.globl    getArrayB
.type    getArrayB, @function
getArrayB:
endbr64
push    rbp                     #сохраняем rbp на стек
mov    rbp, rsp                    #rbp := rsp
mov    r14d, edi     #указывает где на стеке разместить первый аргумент функции (переменная sizeA)
mov    r12d, 0        #счётчик цикла (переменная i)
jmp    .L5                         #перемещение в .L5
.L6:                                #тело цикла
mov    eax, r12d      #eax := адрес переменной цикла
cdqe
lea    rdx, 0[0+rax*4]             #rdx := адрес i-го элемента массива
lea    rax, arrayA[rip]
mov    edx, DWORD PTR [rdx+rax]    #edx := адрес в стеке на значение arrayA[i]
mov    eax, r12d
cdqe
lea    rcx, 0[0+rax*4]
lea    rax, arrayA[rip]
mov    eax, DWORD PTR [rcx+rax]    #eax := адре в стеке на значение arrayA[i]
imul    eax, edx                #умножение arrayA[i] * arrayA[i]
mov    edx, r12d      #erx := адрес в стеке переменной цикла
movsx    rdx, edx
lea    rcx, 0[0+rdx*4]             #rcx := адрес i-го элемента arrayB[i]
lea    rdx, arrayB[rip]
mov    DWORD PTR [rcx+rdx], eax    #присвоение результата arrayB[i] := arrayA[i] * arrayA[i]
add    r12d, 1        #i += 1
.L5:                                #цикл for
mov    eax, r12d      #eax := адрес счётчика (i)
cmp    eax, r14d     #сравнение счётчика c sizeA (аргумент функции)
jl    .L6                         #если eax < sizeA переходим в .L6
nop
nop
pop    rbp                         #очистка стека в исходное состояние
ret                             #возврат в вызывающую функцию
.size    getArrayB, .-getArrayB
.section    .rodata
.LC2:
.string    "Array B: "             #строка для вывода данных
.LC3:
.string    "%d "                   #строка, для формата вывода
.text
.globl    outResult
.type    outResult, @function
outResult:
endbr64
push    rbp                     #сохранение rbp на стек
mov    rbp, rsp                    #rbp := rsp
sub    rsp, 32                     #вычитаем из rsp 32
mov    r14d, edi     #указывает где на стеке разместить первый аргумент функции (переменная sizeA)
lea    rax, .LC2[rip]              #rax := строка для вывода
mov    rdi, rax                    #rdi := rax
mov    eax, 0                      #eax := 0
call    printf@PLT              #вызов функции printf
mov    r12d, 0        #переменная цикла i := 0
jmp    .L8                         #переход к L8
.L9:
mov    eax, r12d      #eax := переменная цикла i
cdqe
lea    rdx, 0[0+rax*4]             #rdx := i-й элемент arrayB[i]
lea    rax, arrayB[rip]
mov    eax, DWORD PTR [rdx+rax]    #eax := адрес в стеке на arrayB[i]
mov    esi, eax
lea    rax, .LC3[rip]
mov    rdi, rax                    #rdi := формат вывода
mov    eax, 0
call    printf@PLT              #вызов функции printf
add    r12d, 1        #переменная цикла i += 1
.L8:
mov    eax, r12d      #eax := переменная цикла i
cmp    eax, r14d     #eax := аргумент метода (sizeA)
jl    .L9                         #если i < sizeA -> переход в .L9
nop
nop
leave                           #очистка стека
ret                             #возврат в вызывающую функцию
.size    outResult, .-outResult
.section    .rodata
.LC4:
.string    "Enter length: "        #строка для вывода
.align 8
.LC5:
.string    "You entered an invalid number." #строка для вывода
.text
.globl    main
.type    main, @function
main:
endbr64
push    rbp     #save caller's frame pointer
mov    rbp, rsp    #establish our frame pointer
sub    rsp, 16     #local variables
lea    rax, .LC4[rip]
mov    rdi, rax    #rdi := rax
mov    eax, 0      #eax := 0
call    printf@PLT  #вызов функции printf
lea    rax, -4[rbp]
mov    rsi, rax        #rsi := rax
lea    rax, .LC1[rip]  #получение формата считывания
mov    rdi, rax    #rdi := rax
mov    eax, 0      #eax := 0
call    __isoc99_scanf@PLT  #вызов функции scanf
mov    r13d, -4[rbp]
mov    edx, r13d  #edx := sizeA
mov    eax, DWORD PTR maxLength[rip]   #eax := maxLength
cmp    edx, eax                        #edx > eax?
jle    .L11                            #если edx <= eax -> переход к .L11
lea    rax, .LC5[rip]                  #rax := строка для вывода
mov    rdi, rax                        #rdi := rax
mov    eax, 0                          #eax := 0
call    printf@PLT                  #вызов функции printf
mov    eax, 0                          #eax := 0
jmp    .L13                            #переход к .L13
.L11:
mov    eax, r13d         #eax := sizeA
mov    edi, eax                        #edi := eax
call    getArrayA                   #вызов функции getArrayA
mov    eax, r13d          #eax := sizeA
mov    edi, eax                        #edi := eax
call    getArrayB                   #вызов функции getArrayB
mov    eax, r13d          #eax := sizeA
mov    edi, eax                        #edi := eax
call    outResult                   #вызов функции outResult
mov    eax, 0                          #eax := 0
.L13:
leave                               #очистка стека
ret                                 #возврат в вызывающую функцию
