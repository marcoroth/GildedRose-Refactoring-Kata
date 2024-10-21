class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name == "Aged Brie"
        item.quality = [item.quality + 1, 50].min
        item.sell_in -= 1
        item.quality = [item.quality + 1, 50].min if item.sell_in < 0

      elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
        item.sell_in -= 1
        item.quality = [item.quality + 1, 50].min
        item.quality = [item.quality + 1, 50].min if item.sell_in < 10
        item.quality = [item.quality + 1, 50].min if item.sell_in < 5
        item.quality = 0 if item.sell_in < 0

      elsif item.name == "Sulfuras, Hand of Ragnaros"
        # being a legendary item, never has to be sold or decreases in Quality

      elsif item.name == "Conjured Mana Cake"
        item.quality = [item.quality - 2, 0].max
        item.sell_in = item.sell_in - 1

      else
        item.quality = [item.quality - 1, 0].max
        item.sell_in = item.sell_in - 1

        item.quality = [item.quality - 1, 0].max if item.sell_in < 0
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
