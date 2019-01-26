TestRecord = Class.new do
  include FieldVault
end

RSpec.describe FieldVault do
  subject { TestRecord }

  it 'has a version number' do
    expect(FieldVault::VERSION).not_to be nil
  end

  it 'adds the encrypted attributes array' do
    test_record = subject.new

    expect(test_record.encrypted_attributes).to eq []
  end

  it 'adds field to the encrypted attributes array' do
    test_record = subject.new
    test_record.field_vault(:passport_number)

    expect(test_record.encrypted_attributes.size).to eq(1)
    expect(test_record.encrypted_attributes.first).to be_a(FieldVault::EncryptedField)
  end
end
