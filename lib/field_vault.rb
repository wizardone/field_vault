require 'byebug'
require "field_vault/version"
require 'field_vault/encrypted_field'

module FieldVault

  def self.included(base)
    base.instance_eval do
      before_save :encrypt_attributes!

      extend ClassMethods
    end
  end

  def encrypt_attributes!
    self.class.encrypted_attributes.each_pair do |key, _value|
      val = public_send(key)
      public_send("#{key}=", "TEST_ENCRYPTION#{val}")
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
