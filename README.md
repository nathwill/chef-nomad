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
using the provided resources for global, server, and client, configuration
blocks.

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
|no_host_uuid|[TrueClass, FalseClass]|
|reserved|Hash|

nomad\_consul\_config
---------------------

|attribute|kind_of|
|---------|-------|
|address|String|
|auth|String|
|auto_advertise|[TrueClass, FalseClass]|
|ca_file|String|
|cert_file|String|
|checks_use_advertise|[TrueClass, FalseClass]|
|client_auto_join|[TrueClass, FalseClass]|
|client_service_name|String|
|key_file|String|
|server_service_name|String|
|server_auto_join|[TrueClass, FalseClass]|
|ssl|[TrueClass, FalseClass]|
|token|String|
|verify_ssl|[TrueClass, FalseClass]|

nomad\_vault\_config
--------------------

|attribute|kind_of|
|---------|-------|
|address|String|
|allow_unauthenticated|[TrueClass, FalseClass]|
|enabled|[TrueClass, FalseClass]|
|create_from_role|String|
|task_token_ttl|String|
|ca_file|String|
|ca_path|String|
|cert_file|String|
|key_file|String|
|tls_server_name|String|
|tls_skip_verify|[TrueClass, FalseClass]|
|token|String|

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
