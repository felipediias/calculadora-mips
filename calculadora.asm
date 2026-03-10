.data
# criação do menu e mensagens
func_menu: .asciiz "======= Menu =======\n  1.Soma\n 2.Subtracao\n 3.Multiplicacao\n 4.Divisao\n 5.Sair\n"
escolha:   .asciiz "Escolha uma opção: "
n1:        .asciiz "Digite n1: "
n2:        .asciiz "Digite n2: "
resultado: .asciiz "O resultado é: "
resto_msg: .asciiz " Resto: "
quociente: .asciiz "quociente: "
msg_div: .asciiz "Erro! \n"
nova_linha: .asciiz "\n"

.text
.globl main
main:
    # print o menu
    li $v0, 4
    la $a0, func_menu
    syscall

    # print a escolha do usuario
    li $v0, 4
    la $a0, escolha
    syscall

    # ler opcao do usuario
    li $v0, 5
    syscall
    move $t0, $v0   # $t0 guarda o valor digitado pelo usuraio 

    # condicoes para ver se é soma, sub, multi ou div
    beq $t0, 1, func_soma
    beq $t0, 2, func_sub
    beq $t0, 3, func_multi
    beq $t0, 4, func_div
    beq $t0, 5, fim
    j main          # se opção inválida, volta ao menu

# função soma
func_soma:
    # pede n1
    li $v0, 4
    la $a0, n1
    syscall
    li $v0, 5
    syscall
    move $t1, $v0  # recebe o valor de n1

    # pede n2
    li $v0, 4
    la $a0, n2
    syscall
    li $v0, 5
    syscall
    move $t2, $v0  # recebe o valor de n2

    # faz a soma
    add $t3, $t1, $t2

    # print a frase 
    li $v0, 4
    la $a0, resultado
    syscall

    # print o resultado da soma
    li $v0, 1
    move $a0, $t3
    syscall

    # nova linha para não ficar colado
    li $v0, 4
    la $a0, nova_linha
    syscall

    j main # volta para o menu
    
# função subtracao
func_sub:
    # pede n1
    li $v0, 4
    la $a0, n1
    syscall
    li $v0, 5
    syscall
    move $t1, $v0  # recebe o valor de n1

    # pede n2
    li $v0, 4
    la $a0, n2
    syscall
    li $v0, 5
    syscall
    move $t2, $v0  # recebe o valor de n2

    # faz a ssubtracao
    sub  $t3, $t1, $t2

    # print a frase 
    li $v0, 4
    la $a0, resultado
    syscall

    # print o resultado da subtracao
    li $v0, 1
    move $a0, $t3
    syscall

    # nova linha
    li $v0, 4
    la $a0, nova_linha
    syscall

    j main #volta para o menu
    
# função multiplicao
func_multi:
    # pede n1
    li $v0, 4
    la $a0, n1
    syscall
    li $v0, 5
    syscall
    move $t1, $v0  # recebe o valor de n1

    # pede n2
    li $v0, 4
    la $a0, n2
    syscall
    li $v0, 5
    syscall
    move $t2, $v0  # recebe o valor de n2

    # faz a multiplicacao
    mul $t3, $t1, $t2

    # print a frase 
    li $v0, 4
    la $a0, resultado
    syscall

    # print o resultado da multiplicacao
    li $v0, 1
    move $a0, $t3
    syscall

    # nova linha
    li $v0, 4
    la $a0, nova_linha
    syscall

    j main #volta para o menu

# funcao divisao
func_div:
    # pede n1
    li $v0, 4
    la $a0, n1
    syscall
    li $v0, 5
    syscall
    move $t1, $v0   # recebe o valor de n1

    # pede n2
    li $v0, 4
    la $a0, n2
    syscall
    li $v0, 5
    syscall
    move $t2, $v0   # recebe o valor de n2

    # divisao por zero
    beq $t2, $zero, erro_div

    # faz a divisao
    div $t1, $t2
    mflo $t3        # utilizado para pegar o quociente
    mfhi $t4        # utilizado para pegar o resto

    # print a frase
    li $v0, 4
    la $a0, quociente
    syscall

    # print quociente
    li $v0, 1
    move $a0, $t3
    syscall

    # print frase resto
    li $v0, 4
    la $a0, resto_msg
    syscall

    # printa resto
    li $v0, 1
    move $a0, $t4
    syscall

    # nova linha
    li $v0, 4
    la $a0, nova_linha
    syscall

    j main   # volta para o menu

erro_div:
    li $v0, 4
    la $a0, msg_div
    syscall
    j main
    
fim:
    li $v0, 10   # syscall 10 = exit
    syscall


