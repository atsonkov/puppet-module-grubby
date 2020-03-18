# @summary Manage bootloader configuration via grubby
#
# @example
#   include ::grubby
#
# @param grub_default_kernel
#   The kernel version to set as default in GRUB.
#
class grubby (
  Optional[String] $grub_default_kernel       = undef,
) {
  contain 'grubby::config'
}
