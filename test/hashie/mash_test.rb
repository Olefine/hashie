require "test_helper"

class MashTest < MiniTest::Test
  def test_init_mash
    hash = Hashie::Mash.new
    assert hash != nil
  end

  def test_responders_attrs
    mash = Hashie::Mash.new
    assert_equal false, mash.name?
    assert_equal nil, mash.name

    mash.name = "My Mash"

    assert_equal "My Mash", mash.name
    assert_equal true, mash.name?
  end

  def test_inspect
    mash = Hashie::Mash.new
    assert_equal '<Hashie::Mash>', mash.inspect
    mash.name = "My Mash"
    assert_equal '<Hashie::Mash name="My Mash">', mash.inspect
  end

  def test_multi_level
    mash = Hashie::Mash.new
    author_mash = mash.author!
    assert !author_mash.nil?
    author_mash.name = "Michael Bleigh"
    assert_equal '<Hashie::Mash name="Michael Bleigh">', mash.author.inspect
  end
end
