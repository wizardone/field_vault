require 'active_record'
db_name = ENV['field_vault_test_db'] || 'field_vault_test'

ActiveRecord::Base.establish_connection(
  adapter:  'postgresql',
  host: 'localhost',
  username: 'postgres',
  database: 'postgres'
)
puts 'Established connection'
ActiveRecord::Base.connection.create_database(db_name)
puts 'Created database field_vault_test'
