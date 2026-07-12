# dotfiles

This repository contains my bootstrapping scripts, configuration files,
and other useful goodies. It allows me to go from a clean install to a
fully functioning development environment in less than an hour.

## Quick start

> [!WARNING]
> Before running this, make sure you understanding what it is doing

```bash
bash <(curl -s https://raw.githubusercontent.com/aadam-ali/dotfiles/HEAD/scripts/bootstrap)
```
OR
```bash
bash <(wget -qO- https://raw.githubusercontent.com/aadam-ali/dotfiles/HEAD/scripts/bootstrap)
```

You can add the `-h` flag to clone the repository using HTTPS instead of
SSH. This is useful when testing this config in a virtual machine where
you don't want to add the SSH key to your GitHub account.

## Philosophy

* Portablity
* Keyboard-centric workflow
* Avoid straying from the defaults where possible
* Minimal distractions

## Layout

* [`bootstrap/`](./bootstrap/) - contains bootstraping scripts (Ansible)
* [`config/`](./config/) - contains config files symlinked into `$HOME/.config`
* [`home/`](./home/) - contains config files symlinked into `$HOME`
* [`scripts/`](./scripts/) -  contains useful scripts that I have written

## Notes

The [`bootstrap`](./scripts/bootstrap) script has been tested against:

* Ubuntu 26.04
* Fedora 43 and 44
* MacOS 26 (but not on a fresh install)
