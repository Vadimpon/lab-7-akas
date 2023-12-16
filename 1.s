section .data
core_count dd 0 ; переменная для хранения количества ядер

format_string db 'Количество ядер процессора: %d', 10, 0 ; добавляем строку форматирования

section .text
    global _start
    extern printf, exit
    
_start:
    ; sysconf для получения информации о конфигурации системы
    mov eax, 158     ; номер вызываемой функции для sysconf
    mov edi, 3       ; параметр для sysconf - _SC_NPROCESSORS_CONF (количество доступных процессоров)
    syscall          ; вызов системного вызова
    mov [core_count], eax ; сохраняем количество ядер в переменной core_count

    ; вывод результата
    mov rdi, format_string
    mov rsi, [core_count]
    xor rax, rax
    call printf

    ; выход из программы
    xor edi, edi
    call exit
