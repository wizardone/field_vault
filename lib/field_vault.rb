require 'byebug'
require "field_vault/version"
require 'field_vault/encrypted_field'

module FieldVault

  def self.included(base)
    base.instance_eval do
      attr_accessor :encrypted_attributes
      before_save :encrypt_attributes!

      extend ClassMethods
    end
  end

  def encrypt_attributes!
    self.class.encrypted_attributes.each do |attr|
      puts " is about to be encrypted"
    end
  end

  module ClassMethods
    def field_vault(*attributes)
      attributes.each do |name|
        encrypted_attributes[name.to_sym] = EncryptedField.new(name: name)
      end
    end

    def encrypted_attributes
      @encrypted_attributes ||= {}
    end
  end
end
