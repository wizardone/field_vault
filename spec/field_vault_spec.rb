require_relative 'active_record/user'
require_relative 'support/custom_encoder'

RSpec.describe FieldVault do
  subject { User }

  it 'has a version number' do
    expect(FieldVault::VERSION).not_to be nil
  end

  it 'adds the encrypted attributes array' do
    expect(subject.encrypted_attributes).to eq({})
  end

  it 'raises an error if methods are not supplied properly' do
    expect do
      subject.field_vault(:passport_number, methods: {some_method: :dodgy})
    end.to raise_error(ArgumentError)
  end

  it 'adds field to the encrypted attributes array' do
    subject.field_vault(:passport_number)

    expect(subject.encrypted_attributes.size).to eq(1)
    expect(subject.encrypted_attributes).to include(:passport_number)
  end

  context 'Base64 encoding' do
    it 'encodes the attributes before save' do
      subject.field_vault(:passport_number)
      user = subject.new(passport_number: '555333666')
      user.save

      expect(user.passport_number).to eq(Base64.encode64('555333666'))
    end

    it 'decodes the attributes for reading' do
      subject.field_vault(:passport_number)
      user = subject.new(passport_number: '555333666')
      user.save

      expect(user.decoded_passport_number).to eq('555333666')
    end
  end

  context 'custom encoding' do
    it 'encodes the attributes before save' do
      subject.field_vault(:passport_number, encoder: CustomEncoder.new)
      user = subject.new(passport_number: '555333666')
      user.save

      expect(user.passport_number).to eq(CustomEncoder.new.encode('555333666'))
    end

    it 'decodes the attributes for reading' do
      subject.field_vault(:passport_number, encoder: CustomEncoder.new)
      user = subject.new(passport_number: '555333666')
      user.save

      # TODO: Kinda stupid, right?
      expect(user.passport_number).to eq('Custom encoded 555333666')
      expect(user.decoded_passport_number).to eq('Decoded custom Custom encoded 555333666')
    end
  end
end
