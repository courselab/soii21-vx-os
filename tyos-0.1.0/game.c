#include <tyos.h>

void game_init() {
    __asm__ volatile(
        "movb $0x00, %%ah;"
        "movb $0x03, %%al;"
        "int $0x10;"

        "movw $0xb800, %%ax;"
        "movw %%ax, %%es;"

        "loop%=:"
        "xor %%di, %%di;"
        "mov $80*25, %%cx;"
        "rep stosw;"
        "jmp loop%=;"
        "hlt;" ::
            : "ax");
    return;
}

/*

*/