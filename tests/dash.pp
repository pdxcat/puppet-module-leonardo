# Setup a working template directory for leonardo

$dashboard_root = '/var/www/leonardo/graphs'
$dashboard_dir  = "${dashboard_root}/${::hostname}"

file { $dashboard_root:
  ensure => 'directory',
}

file { $dashboard_dir:
  ensure  => 'directory',
  require => File[$dashboard_root],
}

leonardo::properties { 'common.yaml':
  target     => "${dashboard_root}/common.yaml",
  properties => { 'linewidth'       => '0.8',
                  'area_alpha'      => '0.7',
                  'timezone'        => 'America/Los_Angeles',
                  'hide_legend'     => 'false',
                  'field_linewidth' => '2', },
  require    => File[$dashboard_dir],
}

leonardo::dashboard { $::hostname:
  target             => "${dashboard_dir}/dash.yaml",
  name               => $::hostname,
  description        => 'System Metrics',
  include_properties => ['common.yaml'],
  require            => File[$dashboard_dir],
}

leonardo::graph { 'cpu':
  target     => "${dashboard_dir}/${name}.graph",
  parameters => { 'title'  => 'Combined CPU Usage',
                  'vtitle' => 'percent',
                  'area'   => 'stacked' },
  fields     => {
                  'iowait' => { 'data'        => "sumSeries(collectd.${::hostname}.cpu*.cpu-wait)",
                                'cacti_style' => 'true',},
                  'system' => { 'data'        => "sumSeries(collectd.${::hostname}.cpu*.cpu-system)",
                                'cacti_style' => 'true',},
                  'user'   => { 'data'        => "sumSeries(collectd.${::hostname}.cpu*.cpu-user)",
                                'cacti_style' => 'true',},
                },
  require    => File[$dashboard_dir],
}
