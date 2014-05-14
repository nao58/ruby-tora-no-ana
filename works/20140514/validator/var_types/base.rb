# encoding: utf-8

require './method'

class Validator::VarType
  class Base
    attr_reader :error_messages

    def initialize options={}
      @name = nil
      @attributes = []
      @options = {
        mandatory: false
      }.merge(options)
      @error_messages = []
      setting
      @name = options[:label] if options.key?(:label)
    end

    def setting; end

    def name name
      @name = name
    end

    def attribute method, setting=nil
      @attributes << {method: method, setting: setting}
    end

    def valid? value
      err = []
      if (value.nil? || value.empty?)
        err << "#{@name}は入力必須です" if @options[:mandatory]
      else
        @attributes.each do |attr|
          msg = Validator::Method.__send__(attr[:method], attr[:setting], @name, value)
          err << msg unless msg.nil?
        end
      end
      @error_messages = err
      @error_messages.empty?
    end

  end
end

