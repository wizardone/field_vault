module FieldVault
  class EncryptedField
    attr_reader :name, :encoder

    def initialize(name:, encoder: Base64)
      @name = name
      @encoder = encoder
    end
  end
end
