require "test_helper"

class Person < Hashie::Dash
  # property :name, :required => true
  # property :email
  # property :occupation, :default => 'Rubyist'
end

class DashTest < MiniTest::Test
  def test_argument_error
    assert_raises ArgumentError do
      p = Person.new
    end
  end

  def test_constructor
    # p = Person.new(:name => "Bob")
    # assert_equal 'Bob', p.name
  end
end
