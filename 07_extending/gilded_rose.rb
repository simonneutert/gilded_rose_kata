# added two new tests for a Milkyway,
# then wrote the code that passes the tests.

class GildedRose
  attr_accessor :name, :item, :quality, :days_remaining
  def initialize(name, quality, days_remaining)
    @name = name
    @quality = quality
    @days_remaining = days_remaining
  end

  def tick
    case @name
    when 'normal'
      item_factory "Normal"
    when 'Aged Brie'
      item_factory "Brie"
    when 'Sulfuras, Hand of Ragnaros'
      item_factory "Sulfuras"
    when 'Backstage passes to a TAKFAL80ETC concert'
      item_factory "Backstage"
    # added case for Milkyway
    when 'Milkyway'
      item_factory "Milkyway"
    end
  end

  private
  def item_factory(name)
    @item = Object.const_get(name).new(self)
    @item.tick
  end
end

class Item
  attr_accessor :parent
  def initialize(parent)
    @parent = parent
  end

  def tick
  end

  private
  def limit_quality_at(limit)
    @parent.quality = limit if @parent.quality >= limit
  end

  def lower_quality_by(amount)
    @parent.quality -= amount
  end

  def raise_quality_by(amount)
    @parent.quality += amount
  end
end

# Inheritance isn't evil
class Normal < Item
  def tick
    @parent.days_remaining -= 1
    return if @parent.quality == 0
    lower_quality_by 1
    lower_quality_by 1 if @parent.days_remaining <= 0
  end
end

class Brie < Item
  def tick
    @parent.days_remaining -= 1
    return if @parent.quality >= 50
    raise_quality_by 1
    raise_quality_by 1 if @parent.days_remaining <= 0
    limit_quality_at(50)
  end
end

class Sulfuras < Item
end

class Backstage < Item
  def tick
    @parent.days_remaining -= 1
    if @parent.days_remaining < 0
      @parent.quality = 0
      return
    end
    raise_quality_by 1
    raise_quality_by 1 if @parent.days_remaining < 10
    limit_quality_at(50)
  end
end

# new Milkyway class that inherites from Item
class Milkyway < Item
  def tick
    @parent.days_remaining -=1
    if @parent.days_remaining < 0
      @parent.quality = 0
      return
    end
    if @parent.days_remaining < 5
      @parent.quality = @parent.quality / 2
    else
      lower_quality_by 1
    end
    @parent.quality = 0 if @parent.quality < 5
  end
end
