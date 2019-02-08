
# docksal
#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with docksal](#setup)
    * [What docksal affects](#what-docksal-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with docksal](#beginning-with-docksal)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

Installs and configures the docksal (github.com/docksal/docksal) program both for use by individual developers and in the 'CI' configuration. Does not manage configurations.

## Setup

### What docksal affects **OPTIONAL**

Installs the fin cli to /usr/local/fin so that any user can execute it. Also creates user-specific config files in <home>/.docksal/docksal.env and assumes full control over that file.

### Setup Requirements **OPTIONAL**

Requires docker installed. For Mac requires docker installed either natively, or virtualbox installed.

### Beginning with docksal

Installing docksal globally is as simple as `include docksal`. Doing this will *not* affect individual user configuration files.

## Usage

### Install and configure docksal for the user `demo`

Install docksal globally and take control over the demo user's configuration file. This will control the file `/home/demo/.docksal/docksal.env` and install the default configuration options.

```puppet
include docksal

docksal::config { 'demo': }
```

### Install and configure docksal for a non-default home path

Although we assume that the home path of the user is `/home/<username>`, this is not applicable to mac nor to all users. If you need to override this value, it is as simple as:

```puppet
include docksal

docksal::config { 'root':
  home_directory => '/root'
}
```

### Install and configure with the CI variable set

Docksal CI mode is useful when you want to have CI server managed development environments. You can create the config for that by using:

```puppet
include docksal

docksal::config { 'ci_user':
  home_directory => '/var/ci_runner',
  ci => true
}
```

## Limitations

* Currently no way of adding custom variables to docksal.env
* User home directory default doesn't ever work for macos
