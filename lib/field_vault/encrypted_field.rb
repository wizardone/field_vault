module FieldVault
  class EncryptedField
    attr_reader :name, :encoder

    def initialize(name:, encoder:)
      @name = name
      @encoder = encoder
    end

    def encrypt(value)
      encoder.public_send(encode_method, value)
    end

    private

    def encode_method
      if encoder == Base64
        :encode64
      else
        #TODO: Give the ability to provide a custom encoding class that responds
        #to an encode method
        :encode
      end
    end

    def decode_method
      if encoder == Base64
        :decode64
      else
        :decode
      end
    end
  end
end
