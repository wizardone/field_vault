module FieldVault
  class EncryptedField
    attr_reader :name

    def initialize(name:)
      @name = name
    end
  end
end
