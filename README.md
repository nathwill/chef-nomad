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

`nomad*config` resources are for configuring nomad. For full documentation,
see the nomad [docs](https://www.nomadproject.io/docs/agent/config.html).

nomad\_config
-------------

|attribute|kind_of|
|---------|-------|
|region|String|
|datacenter|String|
|data_dir|String|
|log_level|String|
|bind_addr|String|
|enable_debug|[TrueClass, FalseClass]|
|ports|Hash|
|addresses|Hash|
|advertise|Hash|
|telemetry|Hash|
|leave_on_interrupt|[TrueClass, FalseClass]|
|leave_on_terminate|[TrueClass, FalseClass]|
|enable_syslog|[TrueClass, FalseClass]|
|syslog_facility|String|
|disable_update_check|[TrueClass, FalseClass]|
|disable_anonymous_signature|[TrueClass, FalseClass]|
|http_api_response_headers|Hash|

nomad\_server\_config
---------------------

|attribute|kind_of|
|---------|-------|
|enabled|[TrueClass, FalseClass]|
|bootstrap_expect|Integer|
|data_dir|String|
|protocol_version|String|
|num_schedulers|Integer|
|enabled_schedulers|Array|
|node_gc_threshold|String|
|rejoin_after_leave|[TrueClass, FalseClass]|
|retry_join|Array|
|retry_interval|String|
|retry_max|Integer|
|start_join|Array|

nomad\_client\_config
---------------------

|attribute|kind_of|
|---------|-------|
|enabled|[TrueClass, FalseClass]|
|state_dir|String|
|alloc_dir|String|
|servers|Array|
|node_id|String|
|node_class|String|
|meta|Hash|
|options|Hash|
|network_interface|String|
|network_speed|Integer|
|max_kill_timeout|String|
|reserved|Hash|

nomad\_atlas\_config
--------------------

|attribute|kind_of|
|---------|-------|
|infrastructure|String|
|token|String|
|join|[TrueClass, FalseClass]|
|endpoint|String|

nomad\_job
----------

Resource for managing nomad jobs via templates. For help configuring jobs,
see the nomad [job spec](https://www.nomadproject.io/docs/jobspec/index.html).

|attribute|kind_of|
|---------|-------|
|cookbook|String|
|source|String|
|path|String|
|variables|Hash|
