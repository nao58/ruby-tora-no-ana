# encoding: utf-8


class FavoriteDb
  def initialize mid
  end
  def get
    [1,2,3]
  end
end

class FavDecorator
  def initialize cookie
    @cookie = cookie
    mid = cookie[:mid]
    @db = FavoriteDb(mid) unless mid.nil?
  end
  def get
    if mid.nil?
      @cookie[:favorite]
    else
      @db.get
    end
  end
  def delte
  end
  def push
  end
end
