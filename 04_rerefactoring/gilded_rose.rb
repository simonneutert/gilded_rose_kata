class GildedRose
  attr_reader :name, :quality, :days_remaining

  def initialize(name, quality, days_remaining)
    @name, @quality, @days_remaining = name, quality, days_remaining
  end

  def tick
    # calls a method
    if @name == 'normal'
      return normal_tick
    end
    # 4 tests fail

    def normal_tick
      # sexy version
      # passes tests
      @days_remaining -= 1
      return if @quality == 0
      @quality -= 1
      @quality -= 1 if @days_remaining <= 0
    end

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
