# @summary Applies desired configuration via grubby
#
# This is a private class, that performs the necessary changes via grubby
#
class grubby::config {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $grubby::default_kernel {

    $_default_kernel = "/boot/vmlinuz-${grubby::default_kernel}"

    exec { 'set default kernel':
      command => "/sbin/grubby --set-default=${_default_kernel}",
      path    => ['/bin','/usr/bin'],
      unless  => "/sbin/grubby --default-kernel | grep -q ${_default_kernel}",
    }
  }

  $grubby::kernel_opts.each | $opt, $fields | {
    $scope = $fields[scope] ? {
      Undef   => 'DEFAULT',
      default => $fields[scope],
    }

    $_opt = $fields[value] ? {
      Undef   => $opt,
      default => "${opt}=${fields[value]}",
    }

    case $fields[ensure] {
      Undef, 'present': {
        exec { "Ensure ${_opt} kernel option is set for ${scope}":
          command => "/sbin/grubby --update-kernel=${scope} --args=${_opt}",
          path    => ['/bin','/usr/bin'],
          unless  => "test `/sbin/grubby --info=${scope} | grep -c ^args=` == \
                     `/sbin/grubby --info=${scope} | grep ^args= | grep -c ${_opt}`",
        }
      }
      'absent': {
        exec { "Ensure ${_opt} kernel option is absent for ${scope}":
          command => "/sbin/grubby --update-kernel=${scope} --remove-args=${opt}",
          path    => ['/bin','/usr/bin'],
          unless  => "test `/sbin/grubby --info=${scope} | grep -c ^args=` == \
                     `/sbin/grubby --info=${scope} | grep ^args= | grep -vwc ${opt}`",
        }
      }
      default: {
        fail('Incorect value of field ensure for $opt kernel option!')
      }
    }
  }
}
