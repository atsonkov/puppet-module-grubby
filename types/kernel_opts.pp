# @summary Parameters for each kernel argument
#
type Grubby::Kernel_Opts = Struct[
  {
    Optional['ensure'] => Enum['present','absent'],
    Optional['value']  => Variant[Integer,String[1]],
    Optional['scope']  => Variant[Enum['DEFAULT','ALL'],Pattern[/^TITLE=.+$/]],
  }
]

