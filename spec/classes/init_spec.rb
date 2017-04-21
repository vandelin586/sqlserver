require 'spec_helper'
describe 'sql' do
  context 'with default values for all parameters' do
    it { should contain_class('sql') }
  end
end
