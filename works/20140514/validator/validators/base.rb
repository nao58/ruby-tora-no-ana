# encoding: utf-8

class Validator
  class Base
    attr_reader :error_messages

    def initialize
      @vars = {}
      @error_messages = {}
      setting
    end

    def setting; end

    def valid? params
      err = {}
      @vars.each do |key, var|
        err[key] = var.error_messages unless var.valid?(params[key])
      end
      @error_messages = err
      @error_messages.empty?
    end

    protected
    def variable key, var_type, options={}
      require File.join(File.dirname(__FILE__), '..', 'var_types', var_type.to_s)
      class_name = var_type.to_s.split('_').map {|w| w.capitalize}.join
      @vars[key] = Validator::VarType.const_get(class_name).new(options)
    end

    def var_attr key, attr_method, attr_setting=nil
      @vars[key].attribute attr_method, attr_setting
    end

  end
end
