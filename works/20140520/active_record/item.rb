# encoding: utf-8

class Item
end

np_id = 7777
#item = item_list.search(:npid => np_id)
#item = Item.new(np_id)

# create
Item.new == Item.create

# find one
Item.get(:id) == Item.find(:id) == Item(:id)
# => Item

# delete
item = Item.get(:id)
item.delete

# search
Item.select == Item.search
Item.ranking
Item.search_by_brand_id
# => Array(Item)

Brand.items
class Brand
  def items
    Item.search_by_brand_id(@id)
  end
end

Item.delete

all_items = Item.all
items = all_items.search(params)
items = Item.search(prams)
items.search(params)


class Ranking
  def self.get(params)
  end
end

rank = Ranking.get(params)
rank.each do |rank_item|
  Item.get(rank.np_id)
  rank.item

class RankingList < Array

  def initialize items
    self = items
  end

end

ranking = Item.ranking(category:...)
ranking.each do |item|
end
ranking.recalc
ranking.category





