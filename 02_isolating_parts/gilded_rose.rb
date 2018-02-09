# Sandi checked the tests - they were clustered by category
# like "normal", "brie", etc.
#
# so she renders all tests that target "normal" useless
# by returning if @name == 'normal'
# she isolates a part of what needs to refactored (step by step)
class GildedRose
  attr_reader :name, :quality, :days_remaining

  def initialize(name, quality, days_remaining)
    @name, @quality, @days_remaining = name, quality, days_remaining
  end

  def tick
    # first, she shoots down 'normal'
    if @name == 'normal'
      return
    end
    # 4 tests fail

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
  end
end
