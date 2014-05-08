# encoding: utf-8

class Boomerang

  def self.on_error &block
    @@on_error = block
  end

  def self.read
    read_from_database
  end

  def self.read_from_database
    ret = %w(d1 d2 e3 d4 e5 d6 e8)
    ret.each do |r|
      if r.start_with?('e')
        stop_proc = @@on_error.call(r)
        break if stop_proc
      else
        p "exec #{r}"
      end
    end
  end

end

#### func 1 : メールで飛ばす ####
Boomerang.on_error do |data|
  p "send mail to hagi about #{data}"
  false
end
x = Boomerang.read
p x


#### func 2 : 標準出力 ####
Boomerang.on_error do |data|
  p "error!: #{data}"
  true
end
x = Boomerang.read
p x



