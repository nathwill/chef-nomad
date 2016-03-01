# nomad

Simple cookbook for installing/managing [Nomad](https://www.nomadproject.io/), a
distributes, highly-available, datacenter-aware scheduler.

Recipes
=======

nomad::install
--------------
Downloads and installs nomad from the URL specified in `attributes/install.rb`.

nomad::configure
----------------
Sets up minimal default configuration (controlled by `attributes/configure.rb`
using the provided resources for global, server, client, and atlas
configuration blocks.

nomad::manage
-------------
Installs a system service definition for nomad, using provided daemon args in
`attributes/manage.rb`, and enable and start the service.

Resources
=========

nomad\_config
-------------

nomad\_server\_config
---------------------

nomad\_client\_config
---------------------

nomad\_atlas\_config
--------------------

nomad\_job
----------

