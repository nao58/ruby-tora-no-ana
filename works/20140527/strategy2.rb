# encoding: utf-8

# 委譲

class FavoriteDb
  def initialize mid
  end
  def get
    [1,2,3]
  end
end

class FavoriteCookie
  def initialize cookie
  end
  def get
    [100,200,300]
  end
end

class FavDecorator
  def initialize cookie
    mid = cookie[:mid]
    if mid.nil?
      @storage = FavoriteCookie.new(cookie)
    else
      @storage = FavoriteDb.new(mid)
    end
  end

  def get
    @storage.get
  end
  def delete
    @storage.delete
  end
end


