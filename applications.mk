### applications

.PHONY: applications
applications: applications/basic applications/default applications/games applications/kde

.PHONY: applications/base
applications/base:
	rpm-ostree install --idempotent vim make zsh distrobox
	# reboot is needed so the base packages are installed
	if ! command -v distrobox > /dev/null; then exit 1; fi
	sudo usermod -s /usr/bin/zsh clemens

.PHONY: steambox
steambox:
	distrobox assemble create --name steambox --replace
