# @summary Manage bootloader configuration via grubby
#
# @example Include Class
#   include ::grubby
#
# @example Specify Default Kernel
#   class{'grubby:
#     default_kernel => 'vmlinuz-4.18.0-240.15.1.el8_3.x86_64',
#   }
#
# @example Add and Remove Kernel Options
#   class{'grubby':
#     kernel_opts => {
#       audit  => {
#         ensure => present,
#         value  => 1,
#         scope  => 'DEFAULT',
#       },
#       audit_backlog_limit => {
#         value => 1,
#       },
#       selinux => {
#         'ensure' => 'absent',
#         'scope'  => 'ALL',
#       }
#     }
#   }
#
# @param default_kernel
#   The kernel version to set as default in the bootloader.
# @param kernel_opts
#   The kernel options that should be managed
#   for the default kernel
#   If ensure is not specified, present will be used (the other option being absent)
#   If scope is not specified, DEFAULT will be used (valid options are also ALL or specific kernel)
#   Example:
#     audit:
#       ensure: present
#       value: 1
#       scope: DEFAULT
#     audit_backlog_limit:
#       value: 8192
#     selinux:
#       ensure: absent
#       scope: ALL
#     enforcing:
#       ensure: absent
#
class grubby (
  Optional[String[1]] $default_kernel                         = undef,
  Optional[Hash[String[1], Grubby::Kernel_Opts]] $kernel_opts = {},
) {
  contain 'grubby::config'
}
