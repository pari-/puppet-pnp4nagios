class pnp4nagios (
  $backend_name,
  $ensure                          = $pnp4nagios::params::ensure,
  $package                         = $pnp4nagios::params::package,
  $auto_upgrade                    = $pnp4nagios::params::auto_upgrade,
  $config                          = $pnp4nagios::params::config,
  $service_name                    = $pnp4nagios::params::service_name,
  $service_ensure                  = $pnp4nagios::params::service_ensure,
  $service_enable                  = $pnp4nagios::params::service_enable,
  $npcd_config                     = $pnp4nagios::params::npcd_config,
  $npcd_config                     = $pnp4nagios::params::npcd_config,
  $apache_config                   = $pnp4nagios::params::apache_config,
  $nagios3_config                  = $pnp4nagios::params::nagios3_config,
  $npcd_defaults                   = $pnp4nagios::params::npcd_defaults,
  $rewrite_pnp4nagios_alias        = $pnp4nagios::params::rewrite_pnp4nagios_alias,
  $add_npcdmod_neb_module          = $pnp4nagios::params::add_npcdmod_neb_module,
  $rewrite_pnp4nagios_rewritebase  = $pnp4nagios::params::rewrite_pnp4nagios_rewritebase,
  $rewrite_pnp4nagios_nagios_base  = $pnp4nagios::params::rewrite_pnp4nagios_nagios_base,
  $disable_event_broker_options    = $pnp4nagios::params::disable_event_broker_options,
  $enable_process_performance_data = $pnp4nagios::params::enable_process_performance_data
) inherits pnp4nagios::params {

  include nagios3

  class {'pnp4nagios::package':}
  class {'pnp4nagios::config':}
  class {'pnp4nagios::service':}

  if $ensure == 'present' {
    Class['pnp4nagios::package'] -> Class['pnp4nagios::config'] ~> Class['pnp4nagios::service']
  } else {
    Class['pnp4nagios::service'] -> Class['pnp4nagios::package']
  }
}
