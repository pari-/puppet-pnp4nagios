class pnp4nagios::package {
  if $pnp4nagios::ensure == 'present' {
    $package_ensure = $pnp4nagios::auto_upgrade ? {
      true  => 'latest',
      false => 'installed',
    }
  } else {
    $package_ensure = 'purged'
  }

  package {$pnp4nagios::package:
    ensure          => $package_ensure,
    provider        => 'aptbpo',
    install_options => { '-t' => 'squeeze-backports' },
  }
}
