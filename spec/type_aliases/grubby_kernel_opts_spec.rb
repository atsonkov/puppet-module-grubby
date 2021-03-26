require 'spec_helper'

describe 'Grubby::Kernel_Opts' do
  it { is_expected.to allow_value('ensure' => 'present') }
  it { is_expected.to allow_value('ensure' => 'absent') }
  it { is_expected.to allow_value('value'  => 22) }
  it { is_expected.to allow_value('value'  => 'foobar') }
  it { is_expected.to allow_value('scope'  => 'ALL') }
  it { is_expected.to allow_value('scope'  => 'DEFAULT') }
  it { is_expected.to allow_value('scope'  => 'TITLE="CentOS Linux (4.18.0-240.15.1.el8_3.x86_64) 8"') }

  it {
    is_expected.to allow_value(
      'ensure' => 'present',
      'value'  => 25,
      'scope'  => 'TITLE="CentOS Linux (4.18.0-240.15.1.el8_3.x86_64) 8"',
    )
  }

  it { is_expected.not_to allow_value('ensure' => 'foo') }
  it { is_expected.not_to allow_value('value' => true) }
  it { is_expected.not_to allow_value('value' => 'spaced value') }
  it { is_expected.not_to allow_value('scope' => 'foo') }
end
