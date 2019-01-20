TestRecord = Class.new do
  include FieldVault
end

#class TestRecord
#  include FieldVault
#end

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

    expect(test_record.encrypted_attributes).to eq [:passport_number]
  end
end
