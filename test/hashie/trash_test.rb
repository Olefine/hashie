require "test_helper"

module TrashMock
  class Person < Hashie::Trash
    property :first_name, :from => :firstName
    property :created_at, :from => :creation_date, :transform_with => lambda { |v| Time.new(v) }
    property :id, :with => lambda {|v| v.to_i}
  end
end

class TrashTest < MiniTest::Test
  def test_translated_from
    p = TrashMock::Person.new(:firstName => "Bob", :id => "1", :creation_date => '2012-03-30 17:23:28')
    assert_equal "Bob", p.first_name
  end
  
  def test_transform_with
    p = TrashMock::Person.new(:id => "1", :creation_date => '2012-03-30 17:23:28')
    assert_equal Fixnum, p.id.class
    assert_equal Time, p.created_at.class
  end
  
  def test_absent_lambda_property_with_initialize
    p = TrashMock::Person.new
    assert p
  end
end
