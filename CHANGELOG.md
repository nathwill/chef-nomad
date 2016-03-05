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
