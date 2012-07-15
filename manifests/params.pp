class pnp4nagios::params {
  $ensure = 'present'
  $auto_upgrade = false
  $service_ensure = 'running'
  $service_enable = true

  $rewrite_pnp4nagios_alias = true
  $enable_npcdmod_neb_module = true
  $rewrite_pnp4nagios_rewritebase = true
  $rewrite_pnp4nagios_nagios_base = true
  $disable_event_broker_options = true
  $enable_process_performance_data = true


#/etc/pnp4nagios/npcd.conf
  $user = 'nagios'
  $group = 'nagios'
  $log_type = 'syslog'
  $npcd_log_file = '/var/log/pnp4nagios/npcd.log'
  $max_logfile_size = '10485760'
  $npcd_log_level = '0'
  $perfdata_spool_dir = '/var/spool/pnp4nagios/npcd/'
  $perfdata_file_run_cmd = '/usr/lib/pnp4nagios/libexec/process_perfdata.pl'
  $perfdata_file_run_cmd_args = '-b'
  $identify_npcd = '1'
  $npcd_max_threads = '5'
  $sleep_time = '15'
  $load_threshold = '0.0'
  $perfdata_file = '/var/spool/pnp4nagios/nagios/perfdata.dump'
  $perfdata_spool_filename = 'perfdata'
  $perfdata_file_processing_interval = '15'

#/etc/pnp4nagios/process_perfdata.cfg
  $timeout = '15'
  $use_rrds = '1'
  $rrdpath = '/var/lib/pnp4nagios/perfdata'
  $rrdtool = '/usr/bin/rrdtool'
  $cfg_dir = '/etc/pnp4nagios'
  $rrd_storage_type = 'SINGLE'
  $rrd_heartbeat = '8460'
  $rra_cfg = '/etc/pnp4nagios/rra.cfg'
  $rra_step = '60'
  $pp_log_file = '/var/log/pnp4nagios/perfdata.log'
  $pp_log_level = '0'
  $xml_enc = 'UTF-8'
  $xml_update_delay = '0'
  $rrd_daemon_opts = ''
  $stats_dir = '/var/log/pnp4nagios/stats'
  $prefork = '1'
  $gearman_host = 'localhost:4730'
  $requests_per_child = '10000'
  $encryption = '1'
  $key = 'should_be_changed'


  case $::operatingsystem {
    'Debian': {
      $package = [ 'pnp4nagios' ]
      $config = '/etc/pnp4nagios/config.php'
      $service_name = 'npcd'
      $npcd_config = '/etc/pnp4nagios/npcd.cfg'
      $process_perfdata_config = '/etc/pnp4nagios/process_perfdata.cfg'
      $apache_config = '/etc/pnp4nagios/apache.conf'
      $nagios3_config = '/etc/nagios3/nagios.cfg'
      $npcd_defaults = '/etc/default/npcd'
    }
    default: {
      fail("\"${module_name}\" is not supported on \"${::operatingsystem}\"")
    }
  }

}
