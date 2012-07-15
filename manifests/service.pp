class pnp4nagios::service {

  service {$pnp4nagios::service_name:
    ensure     => $pnp4nagios::service_ensure,
    enable     => $pnp4nagios::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }

}
