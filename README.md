# puppet-module-grubby

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with grubby](#setup)
    * [What grubby affects](#what-grubby-affects)
    * [Beginning with grubby](#beginning-with-grubby)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

The Grubby Puppet module allows for managing the GRUB configuration using Grubby

## Setup

### What grubby affects

This module can be used to manage the boot loader configuration like setting default kernel, add or remove kernel arguments.

It modifies mostly the files under /boot.

### Beginning with grubby

    include ::grubby

## Usage

Include usage examples for common use cases in the **Usage** section. Show your users how to use your module to solve problems, and be sure to include code examples. Include three to five examples of the most important or common tasks a user can accomplish with your module. Show users how to accomplish more complex tasks that involve different types, classes, and functions working in tandem.

## Reference

Please check REFERENCE.md

## Limitations

This module should work with all platforms that can use grubby for managing their configuration, but is primary developed for and tested on RHEL 8.

## Development

Please use Puppet Development kit (pdk)

Validate syntax

    pdk validate

Run unit tests

    pdk test unit

For details on how to add code comments and generate documentation with Strings, see the Puppet Strings [documentation](https://puppet.com/docs/puppet/latest/puppet_strings.html) and [style guide](https://puppet.com/docs/puppet/latest/puppet_strings_style.html)

Preparation for release: Please check CONTRIBUTING.md

