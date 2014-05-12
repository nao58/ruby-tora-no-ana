# encoding: utf-8

class SampleController

  def self.login params
    v = Validator.new(:login)
    res = v.valid(params, error: :only_first)
    p res
    p v.errors
  end

  def self.register_user params
    v = Validator.new(:register_user)
    res = v.valid(params, error: :all)
    p res
    p v.errors
  end

end

class Validator
  attr_reader :errors

  def initialize type
    @type = type
    # ホントはyamlファイルから取得
    @settings = {
      :login => {
        :id => {mandatory: true, min_length: 6},
        :pwd => {mandatory: true, min_length: 8}
      },
      :register_user => {
        :id => {mandatory: true, min_length: 6},
        :name => {mandatory: true},
        :email => {email: true}
      }
    }
    @setting = @settings[type]
  end

  def valid params, options={}
    opts = {
      error: :all
    }.merge(options)
    @errors = {}.tap do |res|
      @setting.each do |key, setting|
        error = false
        setting.each do |setting_key, setting_val|
          val = params.key?(key) ? params[key] : nil
          if val.nil?
            error = "Parameter #{key} is mandatory." if setting_key == :mandatory
          else
            error = Rules.send(setting_key, key, val, setting_key, setting_val)
          end
          break if error
        end
        res[key] = error if error
        break if error && opts[:error]==:only_first
      end
    end
    @errors.empty?
  end

  class Rules

    def self.mandatory key, val, skey, sval
      false
    end

    def self.min_length key, val, skey, sval
      "The length of #{key} should be more than #{sval}." if val.length < sval
    end

    def self.email key, val, skey, sval
      "Invalid format '#{val}' as email." unless val =~ /^[0-9a-zA-Z\._]+@[0-9a-zA-Z\._]+$/
    end

  end

end

SampleController.login id: nil
SampleController.login id: 'hagiwara', pwd: 'hogehoge'
SampleController.register_user id: 'hagiwara', name: 'hagiwaratakashi', email: 'hagi@netprice.com'
