define leonardo::dashboard (
  $target,
  $description,
  $include_properties = [],
) {

  file { $target:
    ensure => present,
    mode   => '0755'
  }->
  yaml_setting { "dashboard-${name}":
    target  => $target,
    key     => 'name',
    value   => $name,
  }->
  yaml_setting { "dashboard-${name}-description":
    target  => $target,
    key     => 'description',
    value   => $description,
  }->
  yaml_setting { "dashboard-${name}-properties":
    target  => $target,
    key     => 'include_properties',
    value   => $include_properties,
  }
}
