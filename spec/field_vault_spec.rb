require_relative 'active_record/user'
require 'byebug'
RSpec.describe FieldVault do
  subject { User }

  it 'has a version number' do
    expect(FieldVault::VERSION).not_to be nil
  end

  it 'adds the encrypted attributes array' do
    #test_record = subject.new
    #expect(test_record.encrypted_attributes).to eq []
    expect(subject.encrypted_attributes).to eq []
  end

  it 'adds field to the encrypted attributes array' do
    subject.field_vault(:passport_number)

    expect(subject.encrypted_attributes.size).to eq(1)
    expect(subject.encrypted_attributes.first).to be_a(FieldVault::EncryptedField)
  end
end
