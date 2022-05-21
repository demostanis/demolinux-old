To build packages, build the ISO and test it inside QEMU:

  `# make`

To build packages only:

  `# make build-packages`

To only build specific packages:

  `# make build-packages P="neo wayfire lokinet"`

To only build the ISO:

  `# make build`

To build the ISO and run it in QEMU:

  `# make buildnrun`

To SSH in the QEMU VM (ensure you have a password set & started sshd):

  `# make ssh`

