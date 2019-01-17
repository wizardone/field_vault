require "field_vault/version"

module FieldVault

  def self.included(base)
    base.instance_eval(%Q{
      class << self
        attr_accessor :encrypted_attributes
      end
    })
  end

  def field_vault(*attributes)
    attributes.each do |name|
      encrypted_attributes << EncryptedField.new(name: name)
    end
  end
end
