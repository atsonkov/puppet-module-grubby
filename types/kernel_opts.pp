# @summary Parameters for each kernel argument
#
type Grubby::Kernel_Opts = Struct[
  {
    Optional['ensure'] => Enum['present','absent'],
    Optional['value']  => Variant[Pattern[/^\S+$/],Integer],
    Optional['scope']  => Variant[Enum['DEFAULT','ALL'],Pattern[/^TITLE=.+$/]],
  }
]

