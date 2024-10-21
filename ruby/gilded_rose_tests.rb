require 'minitest/autorun'
require_relative 'gilded_rose'

class TestGildedRose < Minitest::Test
  def test_foo
    items = [Item.new("foo", 0, 0)]
    GildedRose.new(items).update_quality()
    assert_equal "foo", items[0].name
  end

  # Elixir of the Mongoose

  def test_decreases_quality_and_sell_in_after_one_day
    items = [Item.new("Elixir of the Mongoose", 5, 1)]
    GildedRose.new(items).update_quality()

    assert_equal 4, items[0].sell_in
    assert_equal 0, items[0].quality
  end

  def test_quality_should_not_be_negative
    items = [Item.new("Elixir of the Mongoose", 5, 0)]
    GildedRose.new(items).update_quality()
    assert_equal 0, items[0].quality
  end

  def test_degrades_twice_as_fast_after_sell_by_date_passed
    items = [Item.new("Elixir of the Mongoose", -1, 5)]

    GildedRose.new(items).update_quality()

    assert_equal (-2), items[0].sell_in
    assert_equal 3, items[0].quality
  end


  # Aged Brie

  def test_increases_quality_and_decreases_sell_in_after_one_day
    items = [Item.new("Aged Brie", 5, 0)]
    GildedRose.new(items).update_quality()

    assert_equal 4, items[0].sell_in
    assert_equal 1, items[0].quality
  end

  def test_quality_should_not_be_over_fifty
    items = [Item.new("Aged Brie", 5, 50)]
    GildedRose.new(items).update_quality()
    assert_equal 50, items[0].quality
  end

  def test_quality_should_increase_twice_as_fast_after_sell_by_date
    items = [Item.new("Aged Brie", 0, 10)]

    GildedRose.new(items).update_quality()

    assert_equal (-1), items[0].sell_in
    assert_equal 12, items[0].quality
  end


  # Sulfuras, Hand of Ragnaros

  def test_sulfuras_does_not_decrease_sell_in_or_quality
    items = [Item.new("Sulfuras, Hand of Ragnaros", 5, 80)]
    GildedRose.new(items).update_quality()

    assert_equal 5, items[0].sell_in
    assert_equal 80, items[0].quality
  end

  # Backstage passes to a TAFKAL80ETC concert

  def test_backstage_passses_increase_quality_within_10_days
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 0)]
    GildedRose.new(items).update_quality()

    assert_equal 9, items[0].sell_in
    assert_equal 2, items[0].quality
  end

  def test_backstage_passses_increase_quality_within_5_days
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 0)]
    GildedRose.new(items).update_quality()

    assert_equal 4, items[0].sell_in
    assert_equal 3, items[0].quality
  end

  def test_backstage_passses_increase_quality_with_1_day
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 10)]
    GildedRose.new(items).update_quality()

    assert_equal 0, items[0].sell_in
    assert_equal 13, items[0].quality
  end

  def test_backstage_passses_increase_quality_after_the_concert
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
    GildedRose.new(items).update_quality()

    assert_equal (-1), items[0].sell_in
    assert_equal 0, items[0].quality
  end

  # Conjured

  def test_conjured_items_degrade_quality_twice_as_fast
    items = [Item.new("Conjured Mana Cake", 5, 5)]
    GildedRose.new(items).update_quality()

    assert_equal 4, items[0].sell_in
    assert_equal 3, items[0].quality
  end
end
