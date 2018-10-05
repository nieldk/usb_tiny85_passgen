# WinAVR cross-compiler toolchain is used here
CC = avr-gcc
OBJCOPY = avr-objcopy
DUDE = avrdude

# Update the lines below to use ATtiny45 and Arduino UNO as ISP
CFLAGS = -Wall -Os -Iusbdrv -mmcu=attiny45 -DF_CPU=16500000
OBJFLAGS = -j .text -j .data -O ihex
DUDEFLAGS = -P com18 -b 19200 -c avrisp -p attiny45
FUSEFLAGS = -U lfuse:w:0xe1:m -U hfuse:w:0xdd:m

# Object files for the firmware (usbdrv/oddebug.o not strictly needed I think)
OBJECTS = usbdrv/usbdrv.o usbdrv/oddebug.o usbdrv/usbdrvasm.o main.o

# By default, build the firmware and command-line client, but do not flash
all: main.hex

# With this, you can flash the firmware by just typing "make flash" on command-line
flash: main.hex
	$(DUDE) $(DUDEFLAGS) -U flash:w:$<

fuse:
	$(DUDE) $(DUDEFLAGS) $(FUSEFLAGS)
    
eeprom: main.eep
	$(DUDE) $(DUDEFLAGS) -U eeprom:w:$<

# Housekeeping if you want it
clean:
	$(RM) *.o *.hex *.elf usbdrv/*.o

# From .elf file to .hex
%.hex: %.elf
	$(OBJCOPY) $(OBJFLAGS) $< $@

# Main.elf requires additional objects to the firmware, not just main.o
main.elf: $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o $@

# Without this dependance, .o files will not be recompiled if you change 
# the config! I spent a few hours debugging because of this...
$(OBJECTS): usbdrv/usbconfig.h

# From C source to .o object file
%.o: %.c	
	$(CC) $(CFLAGS) -c $< -o $@

# From assembler source to .o object file
%.o: %.S
	$(CC) $(CFLAGS) -x assembler-with-cpp -c $< -o $@
