# encoding: utf-8

# Factory

class Favorite::Db
  def initialize mid, site, app_type
    @model = Model::Favorite.find(mid)
    @site = site
  end
  def get
    @model.get(@mid, @site.site, @site.genre, @app_type)
  end
end

class Favorite::Cookie
  def initialize cookie
  end
  def get
    [100,200,300]
  end
end

class Favorite
  def self.select_storage_for_web cookie, app_type
    mid = cookie[:mid]
    if mid.nil?
      FavoriteCookie.new(cookie)
    else
      FavoriteDb.new(mid)
    end
  end
  def self.get_by_mid mid
    FavoriteDb.new(mid)
  end
end

fav = FavFactory.select_storage(cookie)
fav.get
fav.delete

fav.get

# lib/favorite.rb
# lib/favorite/mysql.rb
# lib/favorite/cookie.rb
# lib/favorite/redis.rb
