require "test_helper"

class ClashTest < MiniTest::Test
  def test_init_clash
    skip
    c = Hashie::Clash.new
    assert !c.nil?
  end

  def test_simple
    skip
    expected = {:where => {:abc => 'def'}, :order => :created_at}
    clash = Hashie::Clash.new
    res = clash.where(:abc => 'def').order(:created_at)
    assert_equal expected, res
  end

  def test_noarg
    skip
    expected = {:where => nil, :order => :created_at}
    clash = Hashie::Clash.new
    res = clash.where.order(:created_at)
    assert_equal expected, res
  end

  def test_bang
    # You can also use bang notation to chain into sub-hashes,
    # jumping back up the chain with _end!

    clash = Hashie::Clash.new
    res = clash.where!.abc('def').ghi(123)._end!.order(:created_at)
    expected = {:where => {:abc => 'def', :ghi => 123}, :order => :created_at}
    assert_equal expected, res
  end
end
