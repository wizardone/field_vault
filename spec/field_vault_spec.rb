require_relative 'active_record/user'
require 'byebug'
RSpec.describe FieldVault do
  subject { User }

  it 'has a version number' do
    expect(FieldVault::VERSION).not_to be nil
  end

  it 'adds the encrypted attributes array' do
    expect(subject.encrypted_attributes).to eq({})
  end

  it 'adds field to the encrypted attributes array' do
    subject.field_vault(:passport_number)

    expect(subject.encrypted_attributes.size).to eq(1)
    expect(subject.encrypted_attributes).to include(:passport_number)
  end

  it 'encrypts the attributes before save' do
    subject.field_vault(:passport_number)
    user = subject.new(passport_number: '555333666')
    user.save

    expect(user.passport_number).to eq('TEST_ENCRYPTION555333666')
  end
end
