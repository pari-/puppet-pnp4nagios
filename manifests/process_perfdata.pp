class pnp4nagios::process_perfdata(
  $timeout            = $pnp4nagios::params::timeout,
  $use_rrds           = $pnp4nagios::params::use_rrds,
  $rrdpath            = $pnp4nagios::params::rrdpath,
  $rrdtool            = $pnp4nagios::params::rrdtool,
  $cfg_dir            = $pnp4nagios::params::cfg_dir,
  $rrd_storage_type   = $pnp4nagios::params::rrd_storage_type,
  $rrd_heartbeat      = $pnp4nagios::params::rrd_heartbeat,
  $rra_cfg            = $pnp4nagios::params::rra_cfg,
  $rra_step           = $pnp4nagios::params::rra_step,
  $pp_log_file        = $pnp4nagios::params::pp_log_file,
  $pp_log_level       = $pnp4nagios::params::pp_log_level,
  $xml_enc            = $pnp4nagios::params::xml_enc,
  $xml_update_delay   = $pnp4nagios::params::xml_update_delay,
  $rrd_daemon_opts    = $pnp4nagios::params::rrd_daemon_opts,
  $stats_dir          = $pnp4nagios::params::stats_dir,
  $prefork            = $pnp4nagios::params::prefork,
  $gearman_host       = $pnp4nagios::params::gearman_host,
  $requests_per_child = $pnp4nagios::params::requests_per_child,
  $encryption         = $pnp4nagios::params::encryption,
  $key                = $pnp4nagios::params::key
) {

  file {$pnp4nagios::process_perfdata_config:
    ensure  => present,
    content => template('pnp4nagios/process_perfdata.cfg.erb'),
    notify  => Exec['rewrite_pnp4nagios_config'],
  }

  exec {'rewrite_pnp4nagios_config':
    command     => "sed -i -e \"s|conf\['RRD_DAEMON_OPTS'\].*|conf\['RRD_DAEMON_OPTS'\] = '$rrd_daemon_opts';|\" ${pnp4nagios::config}",
    refreshonly => true,
    path        => '/bin/:/usr/bin',
  }

  Class['pnp4nagios'] -> Class['pnp4nagios::process_perfdata']
}
