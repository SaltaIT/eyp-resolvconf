require 'spec_helper'
describe 'resolvconf' do

  context 'with defaults for all parameters' do
    it { should contain_class('resolvconf') }
  end
end
