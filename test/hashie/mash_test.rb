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
end
