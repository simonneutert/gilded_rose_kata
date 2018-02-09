# This code is not exactly as Sandi's solution in the video.
# This my take on this problem,
# assuming there is nothing more dependent on this code.
#
# Object Factory and Inheritance show what these concepts
# are capable of when used in a straight forward manner.

class GildedRose
  # attr_accessor to make attributes accessible for changes.
  #
  # no more if clauses that can't be understood as a whole.
  # Sandi untangled the logic by using an Object Factory.
  #
  # all logic is now handled in a subobject,
  # which is directly bound to its parent.
  # the code is now much easier to reason about
  # and can be extended swiftly without adding
  # much clutter to the unit.
  attr_accessor :name, :item, :quality, :days_remaining
  def initialize(name, quality, days_remaining)
    @name = name
    @quality = quality
    @days_remaining = days_remaining
  end

  def tick
    # pass Item's Subclass name as String to factory
    case @name
    when 'normal'
      item_factory "Normal"
    when 'Aged Brie'
      item_factory "Brie"
    when 'Sulfuras, Hand of Ragnaros'
      item_factory "Sulfuras"
    when 'Backstage passes to a TAKFAL80ETC concert'
      item_factory "Backstage"
    end
  end

  private
  def item_factory(name)
    @item = Object.const_get(name).new(self)
    @item.tick
  end
end

class Item
  # Item is bound to an instance of a class
  attr_accessor :parent
  def initialize(parent)
    @parent = parent
  end

  def tick
  end

  # these private methods add abstraction
  # but can be useful if Item should be bound
  # to more Objects in the future
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
