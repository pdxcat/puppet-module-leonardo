define leonardo::dashboard (
  $target,
  $description,
  $include_properties = [],
) {

  yaml_setting { "dashboard-${name}":
    target => $target,
    key    => 'name',
    value  => $name,
  }

  yaml_setting { "dashboard-${description}":
    target => $target,
    key    => 'description',
    value  => $description,
  }

  yaml_setting { "dashboard-properties-${name}":
    target => $target,
    key    => 'include_properties',
    value  => $include_properties,
  }
}
