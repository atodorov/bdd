Feature: Pungi Refactor
    https://fedoraproject.org/wiki/Changes/Pungi_Refactor

    Changing how pungi works to make composes more distributed and transparent.

    Background: Fedora 24
        Given the target release is Fedora 24


    Scenario: same workflow for Fedora and RHEL
        Given the releng toolchain has been updated
          And a particular compose workflow exists
         When the same workflow is executed using a RHEL rpm package set
         Then compose completes successfully
          And the resulting images are a valid RHEL compose.

    Scnario: compose build logs are publicly available
        Given a new Fedora compose has been built
         When I open the compose URL
         Then there is logs/ directory under the root directory
          And logs/ contains the build logs.

    Scenario: new compose doesn't break virt-manager
        Given we have a new Fedora compose
          And some filenames are different compared to Fedora 23
         When I try to provision a VM with virt-manager using the HTTP URL
         Then virt-manager recognizes the distro as Fedora 24
          And virt-manager correctly configures the use of virtio drivers
          And virt-manager is able to download vmlinuz+initrd images used during
              install
          And installation is started successfully.

    Scenario: new compose doesn't break anaconda
        Given we have a new Fedora compose
          And some filenames are different compared to Fedora 23
         When I try to install the compose with Anaconda
         Then anaconda automatically finds its install class and product.img
          And default HTTP repositories are configured automatically
          And installation completes successfully.

    Scenario: new compose doesn't break .treeinfo
        Given we have a new Fedora compose
          And some filenames are different compared to Fedora 23
         When I compare the .treeinfo file against a .treeinfo from Fedora 23
         Then all config sections and keys from the Fedora 23 file are present
              in the Fedora 24 file.
