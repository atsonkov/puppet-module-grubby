# @summary Manage bootloader configuration via grubby
#
# @example
#   include ::grubby
#
# @param default_kernel
#   The kernel version to set as default in the bootloader.
# @param kernel_opts
#   The kernel options that should be managed
#   for the default kernel
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
  Optional[String] $default_kernel = undef,
  Optional[Hash]   $kernel_opts    = undef,
) {
  contain 'grubby::config'
}
