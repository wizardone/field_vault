require "field_vault/version"

module FieldVault

  def self.included(base)
    #TODO: Do we keep this on the instance level or the class level?
    #base.extend ClassMethods
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
      #encrypted_attributes << EncryptedField.new(name: name)
      encrypted_attributes << name
    end
  end
end
