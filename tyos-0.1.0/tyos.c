/* <file> - <One-line note about this file>

   Copyright (c) <YEAR>, <AUTHOR>

   This piece of software is a derivative work of SYSeg, by Monaco F. J.
   SYSeg is distributed under the license GNU GPL v3, and is available
   at the official repository https://www.gitlab.com/monaco/syseg.

   This file is part of <PROJECT>.

   <PROJECT> is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include <tyos.h>

void halt() {
    printnl("System halted");
    __asm__ volatile(
        "loop%=:           ;"
        "        hlt       ;"
        "        jmp loop%=;" ::
            :);
}

void __attribute__((fastcall, naked)) read(char* buffer) {
    __asm__ volatile(

        "   mov $0x0, %%si               ;" /* Iteration index for (%bx, %si).
                                             */
        "loop%=:                         ;"
        "   movw $0X0, %%ax              ;" /* Choose blocking read operation.
                                             */
        "   int $0x16                    ;" /* Call BIOS keyboard read service.
                                             */
        "   cmp $0x08, %%al             ;"  /* Compare if char is backspace */
        "   jne not_backspace%=          ;"
        "   dec %%si                     ;"
        "   mov $0x0e, %%ah              ;"
        "   int $0x10                    ;"
        "   mov $0x20, %%al              ;"
        "   int $0x10                    ;"
        "   mov $0x08, %%al              ;"
        "   int $0x10                    ;"
        "   jmp loop%=                   ;"
        "   not_backspace%=:             ;"
        "   movb %%al, %%es:(%%bx, %%si) ;" /* Fill in buffer pointed by %bx. */
        "   inc %%si                     ;"
        "   cmp $0xd, %%al               ;" /* Reiterate if not ascii 13 (CR) */

        "   mov   $0x0e, %%ah            ;" /* Echo character on the terminal.
                                             */
        "   int $0x10                    ;"

        "   jne loop%=                   ;"

        " mov $0x0e, %%ah                ;" /* Echo a newline. */
        " mov $0x0a, %%al                ;"
        "   int $0x10                    ;"

        "   movb $0x0, -1(%%bx, %%si)    ;" /* Add buffer a string delimiter. */
        "   ret                           " /* Return from function */

        :
        : "b"(buffer)      /* Ask gcc to store buffer in %bx          */
        : "ax", "cx", "si" /* Aditional clobbered registers.          */
    );
}

void __attribute__((naked)) help() {
    printnl("-----------------List of commands-----------------\n");
    printnl("help - display this list\n");
    printnl("date - display the date dd/mm/yyyy\n");
    printnl("time - display the time hh:mm:ss\n");
    printnl("play - play a game (not implemented at all)\n");
    printnl("clear - clear screen\n");
    printnl("quit - exit\n");
    __asm__("ret");
}

int __attribute__((fastcall, naked)) compare(char* s1, char* s2) {
    __asm__ volatile(
        "    mov %[len], %%cx   ;"
        "    mov $0x1, %%ax     ;"
        "    cld                ;"
        "    repe  cmpsb        ;"
        "    jecxz  equal       ;"
        "    mov $0x0, %%ax     ;"
        "equal:                 ;"
        "    ret                ;"
        :
        : [len] "n"(BUFFER_MAX_LENGTH - 1), /* [len] is a constant.   */
          "S"(s1),         /* Ask gcc to store s1 in %si      */
          "D"(s2)          /* Ask gcc to store s2 is %di      */
        : "ax", "cx", "dx" /* Additional clobbered registers. */
    );

    return 0; /* Bogus return to fulfill funtion's prototype.*/
}

void __attribute__((naked)) get_date() {
    __asm__ volatile(
        "    movb $0x04, %%ah   ;"
        "    clc                ;"
        "    int $0x1A          ;"
        "    movb $0x0e, %%ah   ;"

        "    movb %%dl, %%al    ;"
        "    shr $0x04, %%al    ;"
        "    add $0x30, %%al    ;"
        "    int $0x10          ;"

        "    movb %%dl, %%al    ;"
        "    andb $0x0F, %%al    ;"
        "    add  $0x30, %%al    ;"
        "    int  $0x10          ;"

        "    movb $0x2F, %%al    ;"  // '/'
        "    int  $0x10          ;"

        "    movb %%dh, %%al    ;"
        "    shr $0x04, %%al    ;"
        "    add $0x30, %%al    ;"
        "    int $0x10          ;"

        "    movb %%dh, %%al    ;"
        "    andb $0x0F, %%al    ;"
        "    add  $0x30, %%al    ;"
        "    int  $0x10          ;"

        "    movb $0x2F, %%al    ;"  // '/'
        "    int  $0x10          ;"

        "    movb %%ch, %%al    ;"
        "    shr $0x04, %%al    ;"
        "    add $0x30, %%al    ;"
        "    int $0x10          ;"

        "    movb %%ch, %%al    ;"
        "    andb $0x0F, %%al    ;"
        "    add  $0x30, %%al    ;"
        "    int  $0x10          ;"

        "    movb %%cl, %%al    ;"
        "    shr $0x04, %%al    ;"
        "    add $0x30, %%al    ;"
        "    int $0x10          ;"

        "    movb %%cl, %%al    ;"
        "    andb $0x0F, %%al    ;"
        "    add  $0x30, %%al    ;"
        "    int  $0x10          ;"

        "    ret    ;"
        :
        :
        : "ax", "cx", "dx");
}

void __attribute__((naked)) get_time() {
    __asm__ volatile(
        "    movb $0x02, %%ah   ;"
        "    clc                ;"
        "    int $0x1A          ;"
        "    movb $0x0e, %%ah   ;"

        "    movb %%ch, %%al    ;"
        "    shr $0x04, %%al    ;"
        "    add $0x30, %%al    ;"
        "    int $0x10          ;"

        "    movb %%ch, %%al    ;"
        "    andb $0x0F, %%al    ;"
        "    add  $0x30, %%al    ;"
        "    int  $0x10          ;"

        "    movb $0x3A, %%al    ;"  // '/'
        "    int  $0x10          ;"

        "    movb %%cl, %%al    ;"
        "    shr $0x04, %%al    ;"
        "    add $0x30, %%al    ;"
        "    int $0x10          ;"

        "    movb %%cl, %%al    ;"
        "    andb $0x0F, %%al    ;"
        "    add  $0x30, %%al    ;"
        "    int  $0x10          ;"

        "    movb $0x3A, %%al    ;"  // '/'
        "    int  $0x10          ;"

        "    movb %%dh, %%al    ;"
        "    shr $0x04, %%al    ;"
        "    add $0x30, %%al    ;"
        "    int $0x10          ;"

        "    movb %%dh, %%al    ;"
        "    andb $0x0F, %%al    ;"
        "    add  $0x30, %%al    ;"
        "    int  $0x10          ;"

        "    ret    ;"
        :
        :
        : "ax", "cx", "dx");
}

/*void __attribute__((naked)) get_date(short int* c_y, short int* m_d) {
    __asm__ volatile(
        "    movb $0x04, %%ah   ;"
        "    clc   ;"
        "    int $0x1A          ;"
        "    movw %%cx, (%[year]) ;"
        "    movw %%dx, (%[month]);"
        :
        : [year] "r"(c_y), [month] "r"(m_d)
        : "ax", "cx", "dx", "memory", "cc");
    __asm__("ret");
}*/
