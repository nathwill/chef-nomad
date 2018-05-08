# 1.1.0 / 2018-05-08

* update to 0.8.3
* fix systemd unit problem (thanks @potato20!)

# 1.0.2 / 2018-04-17

* add new options for 0.8
* update to 0.8

# 1.0.1 / 2018-02-28

* update documentation
* add cluster example suites in test-kitchen
* remove name property for nomad_config

# 1.0.0 / 2018-02-28

* rework to use custom resources
* add new resources
* remove atlas resource
* use latest nomad
* change config root for clean cutover from old cookbook

# 0.13.0 / 2017-08-14

* support latest systemd cookbook

# 0.12.1 / 2017-06-05

* add no_host_uuid option (thanks @potato20!)

# 0.12.0 / 2017-03-22

* update for 0.5.5 (thanks @dbresson!)

# 0.11.0 / 2017-02-23

* update to 0.5.4 (thanks @erkki!)
* add create_from_vault option (thanks @dbresson!)

# 0.10.1/ 2017-01-04

* fix private data leak in nomad config files (thanks @evan2645!)

# 0.10.0 / 2016-12-07

* update to 0.5.0

# 0.9.0 / 2016-07-06

* update to 0.4.0 release
* add consul-related configuration options (thanks @akhoury6!)

# 0.8.1 / 2016-04-29

* update to 0.3.2

# 0.8.0 / 2016-03-16

* update to 0.3.1
* add new config options reserved, and retry_max

# 0.7.0 / 2016-03-04

* documentation!
* use cadvisor job for testing instead of redis, as it downloads faster
* add CentOS 6 to supported platforms
* add additional configuration options as resource attributes,
  now up to date with the options as of the 0.3.0 release.
* fix nomad_job stop action to use resource name instead of hcl path

# 0.6.4 / 2016-02-26

* update to nomad 0.3.0

# 0.6.3 / 2016-02-14

* add start_join configuration
# 0.6.2 / 2016-01-14

* update for 0.2.3 release (thanks @ryanslade!)
* update test suite platforms

# 0.6.1 / 2015-12-09

* update for 0.2.1 release

# 0.6.0 / 2015-11-20

* update for 0.2.0 release

# 0.5.0 / 2015-10-10

* use latest nomad release
* extended resource attribute validation
* add inital api-related classes

# 0.4.0 / 2015-10-06

* job lifecycle management run/update via notify, stop
* fixed potential for config resource file path collisions
* testing fixes

# 0.3.0 / 2015-10-05

* update to latest release
* fixes for EL 6
* testing fixes for EL 7

# 0.2.0 / 2015-10-03

 - allow alternate config paths
 - allow setting daemon args
 - add network_{interface,speed} attributes
 - add nomad_job resource for managing jobs
 - testing improvements

# 0.1.0 / 2015-10-03

 - initial release
