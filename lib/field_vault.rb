require 'byebug'
require "field_vault/version"
require 'field_vault/encrypted_field'

module FieldVault

  def self.included(base)
    base.extend ClassMethods
    base.instance_eval do
      #attr_accessor :encrypted_attributes
    end
  end

  module ClassMethods
    attr_accessor :encrypted_attributes
    def field_vault(*attributes)
      attributes.each do |name|
        encrypted_attributes << EncryptedField.new(name: name)
      end
    end

    def encrypted_attributes
      @encrypted_attributes ||= []
    end
  end

  def encrypt_attributes!
    @encrypted_attributes.each do |attr|
      puts "#{attr.name} is about to be encrypted"
    end
  end
end
