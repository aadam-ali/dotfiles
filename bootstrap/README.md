# dotfiles/bootstrap

> [!WARNING]
> Before running this playbook or the
> [`bootstrap`](../scripts/bootstrap) script, make sure you
> understanding what they are doing

Ansible playbook to configure machines, invoked by
[`bootstrap`](../scripts/bootstrap).

## Responsibilities

When running this playbook via [`bootstrap`](../scripts/bootstrap), it
will:

* Create an SSH key (and prompt you to add it to GitHub)
* Clone this repository
* Prepare the OS to run the remaining steps
* Create symlinks for the various configuration files and directories
* Setup Ansible in a dedicated virtual environment
* Run the Ansible playbook

## Layout

This playbook follows a flat structure

```bash
bootstrap/
├── bootstrap.yaml
├── common.yaml
├── fedora.yaml
├── macosx.yaml
├── README.md
├── ubuntu.yaml
└── variables.yaml
```

* [`bootstrap.yaml`](./bootstrap.yaml) - is the entrypoint for the playbook
* [`variables.yaml`](./variables.yaml) - contains the variables for the playbook
* [`common.yaml`](./common.yaml) - contains the steps that are OS agnostic
* [`fedora.yaml`](./fedora.yaml), [`macosx.yaml`](./macosx.yaml),
  [`ubuntu.yaml`](./ubuntu.yaml) - contains the steps for specific
  distributions

## Usage

```bash
source $HOME/.local/share/dotfiles-venv/bin/activate

ansible-playbook bootstrap.yaml --ask-become-pass
```
