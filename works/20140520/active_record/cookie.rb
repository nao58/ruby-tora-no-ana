# encdoing: utf-8

class WebServer

  def index
    member_id = Cookie.new(:member_id)
    member_id.set 'hagiwara'
    
    id = request.cookies[get_member_id_cookie]
    response.set_cookie id, {'MemberId'}

    id = cookies[:member_id]
    cookies[:member_id] = id
    cookies.delete :member_id

    cookies.member_id
    cookies.member_id = id
    cookies.delete :member_id

  end

  get '/hogehoge' do
    site.detect
  end

  get '/:site/:genre/goods/:np_id/' do
    site.set params[:site]
  end

  site.detect
  site.set
  site.is_np?
  site.is_cp?
  site.name

  def is_cp
  end

  def cp_name
  end


  /netprice/netprice/goods/
  /goods/list/?opt=netmile
  /netmile/netmile/goods/


  /sp/netmile_campaign

  
end
