class GildedRose
  attr_reader :name, :quality, :days_remaining

  def initialize(name, quality, days_remaining)
    @name, @quality, @days_remaining = name, quality, days_remaining
  end

  def tick
    # calls methods
    case @name
    when 'normal'
      return normal_tick
    when 'Aged Brie'
      return brie_tick
    when 'Sulfuras, Hand of Ragnaros'
      return sulfuras_tick
    when 'Backstage passes to a TAKFAL80ETC concert'
      return backstage_tick
    end
    # 4 tests fail
  end
  def normal_tick
    @days_remaining -= 1
    return if @quality == 0
    @quality -= 1
    @quality -= 1 if @days_remaining <= 0
  end

  def brie_tick
    @days_remaining -= 1
    return if @quality >= 50
    @quality += 1
    @quality += 1 if @days_remaining <= 0
    @quality = 50 if @quality >= 50
  end

  def sulfuras_tick
    return
  end

  def backstage_tick
    @days_remaining -= 1
    if @days_remaining < 0
      @quality = 0
      return
    end
    @quality += 1
    @quality += 1 if @days_remaining < 10
    @quality = 50 if @quality >= 50
  end
end # of GildedRose
