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

See the [docs](https://www.nomadproject.io/docs/agent/index.html) for full details.

See `test/fixtures/cookbooks` and test-kitchen suites for example usage.

---
nomad_config

|property|type|
|---------|----|
|addresses|Hash|
|advertise|Hash|
|bind_addr|String|
|datacenter|String|
|data_dir|String|
|disable_anonymous_signature|[TrueClass, FalseClass]|
|disable_update_check|[TrueClass, FalseClass]|
|enable_debug|[TrueClass, FalseClass]|
|enable_syslog|[TrueClass, FalseClass]|
|http_api_response_headers|Hash|
|leave_on_interrupt|[TrueClass, FalseClass]|
|leave_on_terminate|[TrueClass, FalseClass]|
|log_level|String|
|ports|Hash|
|region|String|
|syslog_facility|String|
|acl|Hash|
|client|Hash|
|consul|Hash|
|sentinel|Hash|
|server|Hash|
|telemetry|Hash|
|tls|Hash|
|vault|Hash|

---

nomad_acl_config

|property|type|
|---------|----|
|enabled|[TrueClass, FalseClass]|
|token_ttl|String|
|policy_ttl|String|
|replication_token|String|

---

nomad_client_config

|property|type|
|---------|----|
|alloc_dir|String|
|chroot_env|Hash|
|enabled|[TrueClass, FalseClass]|
|max_kill_timeout|String|
|no_host_uuid|[TrueClass, FalseClass]|
|meta|Hash|
|network_interface|String|
|network_speed|Integer|
|cpu_total_compute|Integer|
|node_class|String|
|options|Hash|
|reserved|Hash|
|servers|Array|
|state_dir|String|
|gc_interval|String|
|gc_disk_usage_threshold|Integer|
|gc_inode_usage_threshold|Integer|
|gc_max_allocs|Integer|
|gc_parallel_destroys|Integer|

---

nomad_consul_config

|property|type|
|---------|----|
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
|server_http_check_name|String|
|server_serf_check_name|String|
|server_rpc_check_name|String|
|server_auto_join|[TrueClass, FalseClass]|
|ssl|[TrueClass, FalseClass]|
|token|String|
|verify_ssl|[TrueClass, FalseClass]|

---

nomad_server_config

|property|type|
|---------|----|
|authoritative_region|String|
|bootstrap_expect|Integer|
|data_dir|String|
|enabled|[TrueClass, FalseClass]|
|enabled_schedulers|Array|
|encrypt|String|
|node_gc_threshold|String|
|job_gc_threshold|String|
|eval_gc_threshold|String|
|deployment_gc_threshold|String|
|heartbeat_grace|String|
|min_heartbeat_ttl|String|
|max_heartbeats_per_second|Integer|
|non_voting_server|[TrueClass, FalseClass]|
|num_schedulers|Integer|
|protocol_version|String|
|raft_protocol|Integer|
|redundancy_zone|String|
|rejoin_after_leave|[TrueClass, FalseClass]|
|retry_join|Array|
|retry_interval|String|
|retry_max|Integer|
|start_join|Array|
|upgrade_version|String|

---

nomad_telemetry_config

|property|type|
|---------|----|
|disable_hostname|[TrueClass, FalseClass]|
|collection_interval|String|
|use_node_name|[TrueClass, FalseClass]|
|publish_allocation_metrics|[TrueClass, FalseClass]|
|publish_node_metrics|[TrueClass, FalseClass]|
|backwards_compatible_metrics|[TrueClass, FalseClass]|
|disable_tagged_metrics|[TrueClass, FalseClass]|
|statsite_address|String|
|statsd_address|String|
|datadog_address|String|
|datadog_tags|Array|
|prometheus_metrics|[TrueClass, FalseClass]|
|circonus_api_token|String|
|circonus_api_app|String|
|circonus_api_url|String|
|circonus_submission_interval|String|
|circonus_submission_url|String|
|circonus_check_id|String|
|circonus_check_force_metric_activation|[TrueClass, FalseClass]|
|circonus_check_instance_id|String|
|circonus_check_search_tag|String|
|circonus_check_display_name|String|
|circonus_check_tags|String|
|circonus_broker_id|String|
|circonus_broker_select_tag|String|

---

nomad_tls_config

|property|type|
|---------|----|
|ca_file|String|
|cert_file|String|
|key_file|String|
|http|[TrueClass, FalseClass]|
|rpc|[TrueClass, FalseClass]|
|rpc_upgrade_mode|[TrueClass, FalseClass]|
|verify_https_client|[TrueClass, FalseClass]|
|verify_server_hostname|[TrueClass, FalseClass]|

---

nomad_vault_config

|property|type|
|---------|----|
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
