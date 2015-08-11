.PHONY: compile clean major minor patch

emacs ?= $(shell which emacs)
flags ?= --directory .

BASE_FILE = homebrew-mode.el
LISPS = $(BASE_FILE)

default: compile

compile: $(LISPS)
	$(emacs) --batch -Q $(flags) -f batch-byte-compile $<

clean:
	rm *.elc *~

temp ?= $(uuid)

major:
	HM_VERSION_SHIFT=major build/version.awk $(BASE_FILE) > $(uuid).el
	rm $(BASE_FILE)
	mv $(uuid).el $(BASE_FILE)

minor:
	HM_VERSION_SHIFT=minor build/version.awk $(BASE_FILE) > $(uuid).el
	rm $(BASE_FILE)
	mv $(uuid).el $(BASE_FILE)

patch:
	HM_VERSION_SHIFT=patch build/version.awk $(BASE_FILE) > $(uuid).el
	rm $(BASE_FILE)
	mv $(uuid).el $(BASE_FILE)

version=$(shell ack -o -m 1 "[0-9]+\.[0-9]+\.[0-9]+" $(BASE_FILE))
tag:
	git tag -a $(version) -m "v$(version)"
