require 'byebug'
require 'base64'
require 'field_vault/version'
require 'field_vault/encrypted_field'
require 'field_vault/adapter'

module FieldVault

  def self.included(base)
    base.instance_eval do
      Adapter.save_logic.call(base)

      extend ClassMethods
    end
  end

  def encrypt_attributes!
    self.class.encrypted_attributes.each_pair do |key, encrypted_field|
      val = public_send(key)
      public_send("#{key}=", encrypted_field.encode(val))
    end
  end

  module ClassMethods
    def field_vault(*attributes, encoder: Base64, methods: default_methods)
      if methods && methods.keys != [:encode, :decode]
        raise ArgumentError.new('Methods must be a hash including :encode and :decode keys')
      end
      attributes.each do |name|
        encrypted_attributes[name.to_sym] = EncryptedField.new(name: name, encoder: encoder, methods: methods)
        define_decode_method(name)
      end
    end

    def encrypted_attributes
      @encrypted_attributes ||= {}
    end

    private

    def define_decode_method(name)
      define_method("decoded_#{name}") do
        val = public_send(name)
        self.class.encrypted_attributes[name].decode(val)
      end
    end

    def default_methods
      {
        encode: :encode,
        decode: :decode
      }
    end
  end
end
