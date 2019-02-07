module FieldVault
  class EncryptedField
    attr_reader :name, :encoder

    def initialize(name:, encoder: Base64)
      @name = name
      @encoder = encoder
    end

    def encrypt(value)
      encoder.public_send(encrypt_method, value)
    end

    private

    def encrypt_method
      if encoder == Base64
        :encode64
      else
        :unknown
      end
    end
  end
end
