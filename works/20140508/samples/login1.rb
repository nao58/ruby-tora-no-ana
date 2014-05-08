# encoding: utf-8

class User

  attr_reader :last_error, :name

  class LoginError < ::Exception
  end

  def initialize id
    @id = id
    @last_error = nil
  end

  def login pwd
    raise LoginError.new('id is empty.') if @id.nil? || @id.size == 0
    raise LoginError.new('password is empty.') if pwd.nil?
    raise LoginError.new('invalid id or password.') unless pwd == 'hogehoge'
    @name = 'hogehoge'
    @locked = false
    raise LoginError.new('this account has been locked.') if @locked
    true
  rescue LoginError => e
    @last_error = e.message
    false
  end

end

id = "hagi"
pwd = nil

user = User.new(id)
if user.login(pwd)
  p user.name
else
  p "ERROR: #{user.last_error}"
end
  
=begin
begin
  user = User.new(id)
  if user.login(pwd)
    p user.name
  end
rescue User::LoginError => e
  p e.message
rescue
  p "unexpected error. it shouldn't return to user."
end
=end
