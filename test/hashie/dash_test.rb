require "test_helper"

class Person < Hashie::Dash
  property :name, :required => true
  property :email
  property :occupation, :default => 'Rubyist'
end

class DashTest < MiniTest::Test
  def test_argument_error
    assert_raises ArgumentError do
      p = Person.new
    end
  end

  def test_constructor
    p = Person.new(:name => "Bob")
    assert_equal 'Bob', p.name
  end
  
  def test_default_assigns
    p = Person.new(:name => "Bob")
    assert_equal 'Rubyist', p.occupation
  end
  
  def test_get_property_by_index
    p = Person.new(:name => "Bob")
    assert_equal 'Bob', p[:name]
  end
  
  def test_get_wrong_property_by_index
    p = Person.new(:name => "Bob")
    assert_raises NoMethodError do
      p[:awesome]
    end
  end
  
  def test_assign_nil_to_required_property
    p = Person.new(:name => "Bob")
    assert_raises ArgumentError do
      p.name = nil
    end
  end
end
