# astrolinux-bootstrap
astrolinux-bootstrap is an Ansible playbook to bootstrap astronomy software on a Linux based PC or Raspberry Pi.  All software is compiled from source directly from GitHub, SourceForge, etc.  The Ansible playbook ensures the necessary libraries and development packages are installed for compilation.


## Requirements
* A computer running a modern Linux distribution, such as a Raspberry Pi
    * Multicore is recommended
        * ARM
        * x86_64
    * 1GB RAM (more is better)
    * 32GB of storage minimum
* Strongly recommend *not* running this on your daily driver.  The system should be a dedicated astronomy system.


## Installation
1. Install git
```
apt-get install git

dnf install git
```
1. Clone the astrolinux-bootstrap git repository
```
git clone https://github.com/aaronwmorris/astrolinux-bootstrap.git
```
1. Navigate to the astrolinux-bootstrap folder
```
cd astrolinux-bootstrap
```
1. Run setup.sh to install the requisite software
```
./setup.sh
```
 * Note:  You may be prompted for a password for sudo
1. Activate the astrolinux-bootstrap python virtual environment
```
source virtualenv/astrolinux-bootstrap/bin/activate
```
1. Run the ansible playbook
```
# if you need a password for sudo
ansible-playbook -i hosts site.yml --ask-become-pass

# if passwordless sudo is setup
ansible-playbook -i hosts site.yml
```


## Linux Distributions
| Distribution | Primary | Legacy   |
| ------------ | ------- | -------- |
| Ubuntu       | 20.04   | 18.04    |
| Debian       | 11      | 10, 9    |
| Raspian      | 11      | 10       |
| CentOS       | 8       | 7        |
| Fedora       | 34      | 33, 32   |

* Variables for legacy OSs are defined, but packages may no longer build properly


## Software
In no particular order...

| Package          | Current Tag     | 
| ---------------- | --------------- |
| INDI             | v1.9.2          |
| INDIHub          | v1.0.6          |
| INDI Web Manager | HEAD            |
| astrometry.net   | 0.86            |
| ASTAP            | tip             |
| SExtractor       | HEAD            |
| StellarSolver    | 1.8             |
| KStars           | stable-3.5.5    |
| PHD2             | v2.6.10         |
| lin_guider       | 5.0.1           |
| Stellarium       | v0.21.2         |
| oaCapture        | v1.8.0          |
| SkyChart / Cartes du Ciel | V42    |
| CCDciel          | v0.9.76         |
| EqmodGui         | v1.7.0          |
| indistarter      | v2.2.0          |
| Gpredict         | HEAD            |


### Services Installed
* An instance of INDI Web Manager will be setup via SystemD on port 8624.
* xrdp will be setup with a full desktop environment (xfce) for running headless.
