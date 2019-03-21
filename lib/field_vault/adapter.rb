module FieldVault
  class Adapter
    class << self
      def save_logic
        if defined?(ActiveRecord)
          Proc.new { |base| base.before_save :encrypt_attributes!  }
        elsif defined?(Sequel)
          Proc.new {  }
        end
      end
    end
  end
end
