# nomad

Simple cookbook for installing/managing [Nomad](https://www.nomadproject.io/), a
distributed, highly-available, datacenter-aware scheduler.

Recipes
=======

nomad::default
--------------
Includes the install, configure, manage recipes.

nomad::install
--------------
Downloads and installs nomad from the URL specified in attributes..

nomad::configure
----------------
Sets up simple default configuration.

nomad::manage
-------------
configure the agent as a service, manage the service

Resources
=========

`nomad*config` resources are for configuring nomad. For full documentation,
see the nomad [docs](https://www.nomadproject.io/docs/agent/config.html).

See `libraries/data.rb` for list of supported properties.
See `test/fixtures/cookbooks` and test-kitchen suites for example usage.
