module FieldVault
  class EncryptedField
    attr_reader :name, :encoder, :methods

    def initialize(name:, encoder:, methods:)
      @name = name
      @encoder = encoder
      @methods = methods
    end

    def encode(value)
      encoder.public_send(encode_method, value)
    end

    def decode(value)
      encoder.public_send(decode_method, value)
    end

    private

    def encode_method
      if encoder == Base64
        :encode64
      else
        methods[:encode]
      end
    end

    def decode_method
      if encoder == Base64
        :decode64
      else
        methods[:decode]
      end
    end
  end
end
