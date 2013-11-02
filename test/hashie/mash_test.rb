require "test_helper"

class MashTest < MiniTest::Test
  def test_init_mash
    hash = Hashie::Mash.new
    assert hash != nil
  end
end
