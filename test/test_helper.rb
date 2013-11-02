require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  add_filter "/test/"
end

require 'bundler/setup'
Bundler.require

require "minitest/autorun"

class TestCase < MiniTest::Test
end
