require 'byebug'
class User < ActiveRecord::Base
  include FieldVault

  #field_vault :passport_number
 # def self.field_vault(*attributes)
 #   attributes.each do |name|
 #     encrypted_attributes << EncryptedField.new(name: name)
 #   end
 # end

 # def encrypt_attributes!
 #   self.class.encrypted_attributes.each do |attr|
 #     puts "#{attr.name} is about to be encrypted"
 #   end
 # end

 # def self.encrypted_attributes
 #   @encrypted_attributes ||= []
 # end
end
