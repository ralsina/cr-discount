DISCOUNT = discount
SOURCES = $(wildcard $(DISCOUNT)/*.c) $(wildcard $(DISCOUNT)/*.h)

all: build

build: $(DISCOUNT) $(SOURCES)
	cd $(DISCOUNT) && ./configure.sh && make CFLAGS="-O3"
	cp $(DISCOUNT)/libmarkdown.a .

$(DISCOUNT):
	git clone --depth 1 https://github.com/Orc/discount.git

clean:
	rm -rf discount

distclean: clean
	rm -rf *.a
	rm -rf *.so*
