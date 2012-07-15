class pnp4nagios::config {
  file {$pnp4nagios::npcd_defaults:
    ensure  => present,
    content => template('pnp4nagios/npcd.erb'),
  }

  if $pnp4nagios::rewrite_pnp4nagios_alias {
    exec {'rewrite_pnp4nagios_alias':
      command => "sed -i -e 's|Alias [^ ]\+ |Alias /${pnp4nagios::backend_name}/pnp4nagios |' ${pnp4nagios::apache_config}",
      path    => '/bin:/usr/bin',
      onlyif  => "test `grep -q \"Alias /${pnp4nagios::backend_name}/pnp4nagios\" ${pnp4nagios::apache_config}; echo \"\$?\"` -eq 1",
      notify  => Class['check_mk_server::service'],
    }
  }

  if $pnp4nagios::enable_npcdmod_neb_module {
    exec {'enable_npcdmod_neb_module':
      command => "echo \"broker_module=/usr/lib/pnp4nagios/npcdmod.o config_file=${pnp4nagios::npcd_config}\" >>${pnp4nagios::nagios3_config}",
      path    => '/bin:/usr/bin',
      onlyif  => "test `grep -q \"npcdmod.o\" ${pnp4nagios::nagios3_config}; echo \"\$?\"` -eq 1",
      notify  => Class['nagios3::service'],
    }
  }

  if $pnp4nagios::rewrite_pnp4nagios_rewritebase {
    exec {'rewrite_pnp4nagios_rewritebase':
      command => "sed -i -e 's|\(.*\)RewriteBase.*|\1RewriteBase /${pnp4nagios::backend_name}/pnp4nagios|' ${pnp4nagios::apache_config}",
      path    => '/bin:/usr/bin',
      onlyif  => "test `grep -q \"RewriteBase /${pnp4nagios::backend_name}/pnp4nagios\" ${pnp4nagios::apache_config}; echo \"\$?\"` -eq 1",
      notify  => Class['check_mk_server::service'],
    }
  }

  if $pnp4nagios::rewrite_pnp4nagios_nagios_base {
    exec {'rewrite_pnp4nagios_nagios_base':
      command => "sed -i -e \"s|conf\['nagios_base'\].*|conf\['nagios_base'\] = '/${pnp4nagios::backend_name}/cgi-bin/nagios3';|\" ${pnp4nagios::config}",
      path    => '/bin:/usr/bin',
      onlyif  => "test `grep -q \"conf\['nagios_base'\] = '/${pnp4nagios::backend_name}/cgi-bin/nagios3';\" ${pnp4nagios::config}; echo \"$?\"` -eq 1",
      notify  => Class['check_mk_server::service'],
    }
  }

  if $pnp4nagios::disable_event_broker_options {
    augeas {'disable_event_broker_options':
      context => "/files/${pnp4nagios::nagios3_config}",
      changes => [
        'set event_broker_options -1',
      ],
      notify  => Class['nagios3::service'],
    }
  }

  if $pnp4nagios::enable_process_performance_data {
    augeas {'enable_process_performance_data':
      context => "/files/${pnp4nagios::nagios3_config}",
      changes => [
        'set process_performance_data 1',
      ],
      notify  => Class['nagios3::service'],
    }
  }

}

