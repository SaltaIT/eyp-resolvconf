# resolvconf

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What resolvconf affects](#what-resolvconf-affects)
    * [Beginning with resolvconf](#beginning-with-resolvconf)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)

## Overview

This module setups /etc/resolv.conf

## Module Description

Configures /etc/resolv.conf (/etc/resolvconf/resolv.conf.d/base for Ubuntu)

## Setup

Required Modules:
* eyp/chattr

### What resolvconf affects

* Just modifies /etc/resolv.conf
* This can module can break name resolution, consider yourself warned if something goes wrong

### Beginning with resolvconf

To setup resolv.conf to itself:
```puppet
        class { 'resolvconf':
                resolvers => [ '127.0.0.1' ],
                domain    => 'systemadmin.es',
                rotate    => false,
        }
```
To setup resolv with a given list of resolver, alternating queries:

```puppet
        class { 'resolvconf':
                resolvers => [ '8.8.8.8', '8.8.4.4' ],
                domain    => 'systemadmin.es',
                rotate    => true,
        }
```

To setup resolv with a given list of resolver, alternating queries:

```puppet
        class { 'resolvconf':
                resolvers        => [ '64.123.456.78' ],
                domain           => 'example.es',
                searchlist       => [ 'searchexample.es', 'company.es' ],
                rotate           => true,
                timeout          => 10,
                attempts         => 2,
                ignoreifconf     => false,
                disableimmutable => false,
        }
```

## Usage

### resolvconf
* resolvers: array that defines the entries to add.
* domain: string that defines the domain of the entries.
* searchlist: array than defines the names that resolve the entry.
* rotate: if true sets the option rotate.
* timeout: sets the time before a timeout.
* attempts: sets the numbers of attempts.
* ignoreifconf: if set to true ignores dhcp pushed configuration. Only works in systems with resolv.conf.d.
* disableimmutable: disable the immutable bit to resolv.conf.

## Reference
Facter:
* eyp_resolvconf_maxns, to get MAXNS value we need /usr/include/resolv.h to be present. If /usr/include/resolv.h isn't installed before the first execution it will be ignored, however in the first execution it will be installed

## Limitations
* Redhat and derivatives: 6 and 7 releases.
* Ubuntu: 14.
* Others: unsuported.
