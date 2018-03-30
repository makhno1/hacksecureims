# [HackSécuReims] Write-Up - RE3 (Reverse, 200)

## Description :
Jean veut te prouver que ses cours en C ont servi. Pourtant son binaire ne semble pas bien difficile à reverser.


## RE3 :

Pour commencer nous faisons un file sur le binaire [re3](files/r0_290f73b2f9e8047ec8db183a9b6ec9bf) pour voir à quoi nous avons affaire :

```BASH
file r0_290f73b2f9e8047ec8db183a9b6ec9bf 
r0_290f73b2f9e8047ec8db183a9b6ec9bf: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 3.2.0, BuildID[sha1]=abb72eac9db5565140a600a3f0af621cef9531c5, not stripped
```

Nous enchaînons avec un strings sur le binaire :

```BASH
...
Tiny and easy reverse challenge for da HackSecuReims by Phenol. #This challenge is intended for beginners.
[!] Wrong!
[+] Guess my flag: 
%41s
[+] Hell yeah! You won!
;*3$"
GCC: (GNU) 7.2.1 20171215
...
```

Nous continuons en passant avec objdump :



```BASH
0000000000000834 <main>:
 834:	55                   	push   %rbp
 835:	48 89 e5             	mov    %rsp,%rbp
 838:	48 83 ec 40          	sub    $0x40,%rsp
 83c:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
 843:	00 00 
 845:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 849:	31 c0                	xor    %eax,%eax
 84b:	48 8d 3d 7c 02 00 00 	lea    0x27c(%rip),%rdi        # ace <_IO_stdin_used+0x7e>
 852:	b8 00 00 00 00       	mov    $0x0,%eax
 857:	e8 84 fe ff ff       	callq  6e0 <printf@plt>
 85c:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
 860:	48 89 c6             	mov    %rax,%rsi
 863:	48 8d 3d 78 02 00 00 	lea    0x278(%rip),%rdi        # ae2 <_IO_stdin_used+0x92>
 86a:	b8 00 00 00 00       	mov    $0x0,%eax
 86f:	e8 7c fe ff ff       	callq  6f0 <__isoc99_scanf@plt>
 874:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
 878:	48 89 c7             	mov    %rax,%rdi
 87b:	e8 40 fe ff ff       	callq  6c0 <strlen@plt>
 880:	48 83 f8 15          	cmp    $0x15,%rax
 884:	74 05                	je     88b <main+0x57>
 886:	e8 8f ff ff ff       	callq  81a <nope>
 88b:	0f b6 45 c0          	movzbl -0x40(%rbp),%eax
 88f:	3c 55                	cmp    $0x55,%al
 ...
```

Nous constatons qu'il y a beaucoup trop de *cmp* à notre goût :-) , comme si des valeurs étaient comparées à quelque chose par exemple le flag ...

```BASH
objdump -d r0_290f73b2f9e8047ec8db183a9b6ec9bf | grep cmp
 74f:	48 39 f8             	cmp    %rdi,%rax
 7d0:	80 3d 89 08 20 00 00 	cmpb   $0x0,0x200889(%rip)        # 201060 <__TMC_END__>
 7d9:	48 83 3d 0f 08 20 00 	cmpq   $0x0,0x20080f(%rip)        # 200ff0 <__cxa_finalize@GLIBC_2.2.5>
 880:	48 83 f8 15          	cmp    $0x15,%rax
 88f:	3c 55                	cmp    $0x55,%al
 89c:	3c 52                	cmp    $0x52,%al
 8a9:	3c 43                	cmp    $0x43,%al
 8b6:	3c 41                	cmp    $0x41,%al
 8c3:	3c 43                	cmp    $0x43,%al
 8d0:	3c 54                	cmp    $0x54,%al
 8dd:	3c 46                	cmp    $0x46,%al
 8ea:	3c 7b                	cmp    $0x7b,%al
...
```

Pour finir, nous faisons en un one liner en bash pour trouver le flag :

```BASH
objdump -d r0_290f73b2f9e8047ec8db183a9b6ec9bf | grep cmp | cut -d '$' -f 2 | sed -e 's/,%al//g' -e 's/0x//g' | tail -n+5 | tr -d '\n' | xxd -p -r
URCACTF{345y_0n3_n0?}�H9�
```

Nous avons le flag : URCACTF{345y_0n3_n0?}
