class pnp4nagios::npcd(
  $user                              = $pnp4nagios::params::user,
  $group                             = $pnp4nagios::params::group,
  $log_type                          = $pnp4nagios::params::log_type,
  $npcd_log_file                     = $pnp4nagios::params::npcd_log_file,
  $max_logfile_size                  = $pnp4nagios::params::max_logfile_size,
  $npcd_log_level                    = $pnp4nagios::params::npcd_log_level,
  $perfdata_spool_dir                = $pnp4nagios::params::perfdata_spool_dir,
  $perfdata_file_run_cmd             = $pnp4nagios::params::perfdata_file_run_cmd,
  $perfdata_file_run_cmd_args        = $pnp4nagios::params::perfdata_file_run_cmd_args,
  $identify_npcd                     = $pnp4nagios::params::identify_npcd,
  $npcd_max_threads                  = $pnp4nagios::params::npcd_max_threads,
  $sleep_time                        = $pnp4nagios::params::sleep_time,
  $load_threshold                    = $pnp4nagios::params::load_threshold,
  $perfdata_file                     = $pnp4nagios::params::perfdata_file,
  $perfdata_spool_filename           = $pnp4nagios::params::perfdata_spool_filename,
  $perfdata_file_processing_interval = $pnp4nagios::params::perfdata_file_processing_interval
) {
  file {$pnp4nagios::npcd_config:
    ensure  => present,
    content => template('pnp4nagios/npcd.cfg.erb'),
  }

  Class['pnp4nagios'] -> Class['pnp4nagios::npcd']
}
