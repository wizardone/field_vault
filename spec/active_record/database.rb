require 'active_record'
require_relative 'migrate/create_users'
db_name = ENV['field_vault_test_db'] || 'field_vault_test'
db_config = {
  'adapter' =>  'postgresql',
  'host' => 'localhost',
  'user' => 'postgres',
  'database' => db_name,
  'schema_search_path' => 'public'
}

ActiveRecord::Base.establish_connection(db_config.merge('database' => 'postgres'))
ActiveRecord::Base.connection.create_database(db_config['database'])

ActiveRecord::Base.establish_connection(db_config)

CreateUsers.migrate(:up)
