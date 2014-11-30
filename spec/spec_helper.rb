$LOAD_PATH.unshift('config')
$LOAD_PATH.unshift('spec')
require 'simplecov'
require 'config'
require 'rspec/mocks'

unless Object.const_defined?('Mutant')
  require 'simplecov'
  SimpleCov.start do
    add_filter 'spec'
  end
end

RSpec.configure do |c|
  # include spec modules
  # c.include SpecKeys
end
