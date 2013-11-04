require "test_helper"

class ClashTest < MiniTest::Test
  def test_init_clash
    c = Hashie::Clash.new
    assert !c.nil?
  end

  def test_simple
    expected = {:where => {:abc => 'def'}, :order => :created_at}
    clash = Hashie::Clash.new
    res = clash.where(:abc => 'def').order(:created_at)
    assert_equal expected, res
  end

  def test_noarg
    expected = {:where => nil, :order => :created_at}
    clash = Hashie::Clash.new
    res = clash.where.order(:created_at)
    assert_equal expected, res
  end
end
