# refactoring begins by making all "normal" tests pass again
# she calls that stage "lowest hanging green"
# (red, green, refactor)
#
# the key is how she slices the tests to implement a new solution
class GildedRose
  attr_reader :name, :quality, :days_remaining

  def initialize(name, quality, days_remaining)
    @name, @quality, @days_remaining = name, quality, days_remaining
  end

  def tick
    # this is how Sandi creates space
    # it lets her implement a new solution
    # without breaking the object itself
    if @name == 'normal'
      # Sandi calls a new born method for "normal" items
      return normal_tick
    end

    def normal_tick
      # this passes tests - but is ugly
      # "the lowest hanging green"
      if @quality != 0
        if @days_remaining > 0
          @quality -= 1
        end
        if @days_remaining <= 0
          @quality -= 2
        end
      end
      @days_remaining -= 1
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
  end
end
