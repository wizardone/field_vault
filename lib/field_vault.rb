require 'byebug'
require 'base64'
require 'field_vault/version'
require 'field_vault/encrypted_field'

module FieldVault

  def self.included(base)
    base.instance_eval do
      before_save :encrypt_attributes!

      extend ClassMethods
    end
  end

  def encrypt_attributes!
    self.class.encrypted_attributes.each_pair do |key, encrypted_field|
      val = public_send(key)
      public_send("#{key}=", encrypted_field.encrypt(val))
    end
  end

  module ClassMethods
    def field_vault(*attributes, encoder: nil)
      attributes.each do |name|
        encrypted_attributes[name.to_sym] = EncryptedField.new(name: name, encoder: encoder || Base64)
      end
    end

    def encrypted_attributes
      @encrypted_attributes ||= {}
    end
  end
end
