PREFIX = /usr/local

kjv: kjv.sh kjv.awk kjv.tsv
	cat kjv.sh > $@
	echo 'exit 0' >> $@
	echo '#EOF' >> $@
	tar cz kjv.awk *.tsv >> $@
	chmod +x $@

test: kjv.sh
	shellcheck -s sh kjv.sh

clean:
	rm -f kjv

install: kjv
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f kjv $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/kjv
	ln -s $(DESTDIR)$(PREFIX)/bin/kjv $(DESTDIR)$(PREFIX)/bin/grb
	ln -s $(DESTDIR)$(PREFIX)/bin/kjv $(DESTDIR)$(PREFIX)/bin/vul

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/kjv
	rm -f $(DESTDIR)$(PREFIX)/bin/grb
	rm -f $(DESTDIR)$(PREFIX)/bin/vul

.PHONY: test clean install uninstall
