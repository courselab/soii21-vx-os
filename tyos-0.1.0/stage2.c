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

void __attribute__((naked)) init() {
    printnl("Second stage loaded sucessuflly.");
    printnl("Welcome to VX-OS");
    help();
    OperatingSystem();
    halt(); /* Halt the system. */
}

void OperatingSystem() {
    char buffer[BUFFER_MAX_LENGTH];
    while (1) {
        print(nl);
        print(PROMPT);
        read(buffer);
        if (compare(buffer, "help")) {
            help();
            continue;
        }
        if (compare(buffer, "date")) {
            print("Current date is: ");
            get_date();
            continue;
        }
        if (compare(buffer, "time")) {
            print("Current time is: ");
            get_time();
            continue;
        }
        if (compare(buffer, "clear")) {
            clear();
            continue;
        }
        if (compare(buffer, "play")) {
            game_init();
        }
        if (compare(buffer, "quit")) {
            return;
        }
    }
}
