include applications.mk
include customization.mk
include dotfiles.mk
include hosts.mk
# include ./gnome/gnome.mk

.PHONY: all
all: applications/base customization kde

.PHONY: clean
clean:
	rm -rf tmp
