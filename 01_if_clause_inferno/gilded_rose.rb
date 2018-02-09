# code as is
# this was the code why sandi was called in for help
#
# GildedRose.tick stats:
# 16 if statements
# 7 !=
# 2 != with &&
# 3 magic strings
# ? magic numbers

class GildedRose
  attr_reader :name, :quality, :days_remaining

  def initialize(name, quality, days_remaining)
    @name, @quality, @days_remaining = name, quality, days_remaining
  end

  def tick
    if @name != 'Aged Brie' && @name != 'Backstage passes to a TAKFAL80ETC concert'
      if @quality > 0
        if @name != 'Sulfuras, Hand of Ragnaros'
          @quality -= 1
        end
      end
    else
      if @quality < 50
        @quality += 1
        if @name == 'Backstage passes to a TAKFAL80ETC concert'
          if @days_remaining < 11
            if @quality < 50
              @quality += 1
            end
          end
        end
      end
    end
    if @name != 'Sulfuras, Hand of Ragnaros'
      @days_remaining -= 1
    end
    if @days_remaining < 0
      if @name != 'Aged Brie'
        if @name != 'Backstage passes to a TAKFAL80ETC concert'
          if @quality > 0
            if @name != 'Sulfuras, Hand of Ragnaros'
              @quality -= 1
            end
          end
        else
          @quality = @quality - @quality
        end
      else
        if @quality < 50
          @quality += 1
        end
      end
    end
  end # of tick

end # of GildedRose

class GildedRoseTest < Minitest::Test
  # test cluster around magic strings
  def test_normal_item_before_sell_date
    item = GildedRose.new('normal', 10, 5)
    item.tick

    assert_equal 9, item.quality
    assert_equal 4, item.days_remaining
  end
  def test_item_on_sell_date
    item = GildedRose.new('normal', 10, 0)
    item.tick

    assert_equal 8, item.quality
    assert_equal -1, item.days_remaining
  end
  def test_item_after_sell_date
    item = GildedRose.new('normal', 10, -1)
    item.tick

    assert_equal 8, item.quality
    assert_equal -2, item.days_remaining
  end
  def test_item_of_zero_quality
    item = GildedRose.new('normal', 0, 5)
    item.tick

    assert_equal 0, item.quality
    assert_equal 4, item.days_remaining
  end

  def test_brie_before_sell_date
    item = GildedRose.new('Aged Brie', 10, 5)
    item.tick

    assert_equal 11, item.quality
    assert_equal 4, item.days_remaining
  end

  def test_brie_before_sell_date_with_max_quality
    item = GildedRose.new('Aged Brie', 50, 5)
    item.tick

    assert_equal 50, item.quality
    assert_equal 4, item.days_remaining
  end

  def test_brie_on_sell_date
    item = GildedRose.new('Aged Brie', 10, 0)
    item.tick

    assert_equal 12, item.quality
    assert_equal -1, item.days_remaining
  end

  def test_brie_on_sell_date_near_max_quality
    item = GildedRose.new('Aged Brie', 49, 0)
    item.tick

    assert_equal 50, item.quality
    assert_equal -1, item.days_remaining
  end

  def test_brie_on_sell_date_with_max_quality
    item = GildedRose.new('Aged Brie', 50, 0)
    item.tick

    assert_equal 50, item.quality
    assert_equal -1, item.days_remaining
  end

  def test_brie_after_sell_date
    item = GildedRose.new('Aged Brie', 10, -1)
    item.tick

    assert_equal 12, item.quality
    assert_equal -2, item.days_remaining
  end

  def test_brie_after_sell_date_with_max_quality
    item = GildedRose.new('Aged Brie', 50, -1)
    item.tick

    assert_equal 50, item.quality
    assert_equal -2, item.days_remaining
  end

  def test_sulfuras_before_sell_date
    item = GildedRose.new('Sulfuras, Hand of Ragnaros', 10, 5)
    item.tick

    assert_equal 10, item.quality
    assert_equal 5, item.days_remaining
  end
  def test_sulfuras_on_sell_date
    item = GildedRose.new('Sulfuras, Hand of Ragnaros', 10, 0)
    item.tick

    assert_equal 10, item.quality
    assert_equal 0, item.days_remaining
  end
  def test_sulfuras_after_sell_date
    item = GildedRose.new('Sulfuras, Hand of Ragnaros', 10, -1)
    item.tick

    assert_equal 10, item.quality
    assert_equal -1, item.days_remaining
  end

  def test_backstage_pass_long_before_sell_date
    item = GildedRose.new('Backstage passes to a TAKFAL80ETC concert', 10, 13)
    item.tick

    assert_equal 11, item.quality
    assert_equal 12, item.days_remaining
  end

  def test_backstage_pass_medium_close_to_sell_date_upper_bound
    item = GildedRose.new('Backstage passes to a TAKFAL80ETC concert', 10, 20)
    item.tick

    assert_equal 11, item.quality
    assert_equal 19, item.days_remaining
  end

  def test_backstage_pass_medium_close_to_sell_date_upper_bound_at_max_quality
    item = GildedRose.new('Backstage passes to a TAKFAL80ETC concert', 50, 20)
    item.tick

    assert_equal 50, item.quality
    assert_equal 19, item.days_remaining
  end

  def test_backstage_pass_medium_close_to_sell_date_lower_bound
    item = GildedRose.new('Backstage passes to a TAKFAL80ETC concert', 10, 10)
    item.tick

    assert_equal 12, item.quality
    assert_equal 9, item.days_remaining
  end

  def test_backstage_pass_medium_close_to_sell_date_lower_bound_at_max_quality
    item = GildedRose.new('Backstage passes to a TAKFAL80ETC concert', 50, 10)
    item.tick

    assert_equal 50, item.quality
    assert_equal 9, item.days_remaining
  end

  def test_backstage_pass_very_close_to_sell_date_upper_bound
    item = GildedRose.new('Backstage passes to a TAKFAL80ETC concert', 20, 20)
    item.tick

    assert_equal 21, item.quality
    assert_equal 19, item.days_remaining
  end

  def test_backstage_pass_very_close_to_sell_date_upper_bound_at_max_quality
    item = GildedRose.new('Backstage passes to a TAKFAL80ETC concert', 50, 20)
    item.tick

    assert_equal 50, item.quality
    assert_equal 19, item.days_remaining
  end

  def test_backstage_pass_very_close_to_sell_date_lower_bound
    item = GildedRose.new('Backstage passes to a TAKFAL80ETC concert', 20, 1)
    item.tick

    assert_equal 22, item.quality
    assert_equal 0, item.days_remaining
  end

  def test_backstage_pass_very_close_to_sell_date_lower_bound_at_max_quality
    item = GildedRose.new('Backstage passes to a TAKFAL80ETC concert', 50, 1)
    item.tick

    assert_equal 50, item.quality
    assert_equal 0, item.days_remaining
  end

  def test_backstage_pass_on_sell_date
    item = GildedRose.new('Backstage passes to a TAKFAL80ETC concert', 50, 0)
    item.tick

    assert_equal 0, item.quality
    assert_equal -1, item.days_remaining
  end

  def test_backstage_pass_after_sell_date
    item = GildedRose.new('Backstage passes to a TAKFAL80ETC concert', 50, -1)
    item.tick

    assert_equal 0, item.quality
    assert_equal -2, item.days_remaining
  end

end
