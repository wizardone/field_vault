require "field_vault/version"
require 'field_vault/encrypted_field'

module FieldVault

  def self.included(base)
    base.attr_reader :encrypted_attributes
  end

  module ClassMethods
    attr_accessor :encrypted_attributes
  end

  def initialize
    super.tap do
      @encrypted_attributes = []
    end
  end

  def field_vault(*attributes)
    attributes.each do |name|
      encrypted_attributes << EncryptedField.new(name: name)
    end
  end
end
