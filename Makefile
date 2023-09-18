BINS := $(subst .asm,.bin,$(wildcard *.asm))
LIBS := $(wildcard lib/*)

all: $(BINS)

clean:
	rm -rf *.bin

# implicit rule which builds raw asm files.
%.bin: %.asm $(LIBS)
	nasm -f bin $< -o $@


