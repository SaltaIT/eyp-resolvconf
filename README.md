# resolvconf

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What resolvconf affects](#what-resolvconf-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with resolvconf](#beginning-with-resolvconf)
4. [Usage](#usage)
5. [Reference](#reference)
6. [Development](#development)
    * [Contributing](#contributing)

## Overview

This module setups **resolv.conf**

## Module Description

Configures **/etc/resolv.conf** (**resolv.conf.d** on Ubuntu)

## Setup

Optional Modules to disable immutable bit on **resolv.conf**:
* eyp/chattr

### What resolvconf affects

* Modifies /etc/resolv.conf
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
* **resolvers**: array that defines the entries to add.
* **domain**: string that defines the domain of the entries.
* **searchlist**: array than defines the names that resolve the entry.
* **rotate**: if true sets the option rotate.
* **timeout**: sets the time before a timeout.
* **attempts**: sets the numbers of attempts.
* **ignoreifconf**: if set to true ignores dhcp pushed configuration. Only works in systems with resolv.conf.d.
* **disableimmutable**: disable the immutable bit to **/etc/resolv.conf**. eyp-chattr required if set to true (not an actual dependency)

## Reference
Facter:
* **eyp_resolvconf_maxns**, to get MAXNS value we need /usr/include/resolv.h to be present. If /usr/include/resolv.h isn't installed before the first execution it will be ignored, however during the first execution it will be installed so for later executions to be present

## Limitations

Tested on:

* Redhat and derivatives: 5, 6 and 7 releases.
* Ubuntu: 14.04
* SLES 11 SP3

## Development

We are pushing to have acceptance testing in place, so any new feature should
have some test to check both presence and absence of any feature

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
