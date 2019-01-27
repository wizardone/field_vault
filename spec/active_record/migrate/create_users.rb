class CreateUsers < ActiveRecord::Migration[5.0]
  def up
    create_table :users do |t|
      t.string  :name
      t.string  :email
      t.string  :passport_number
      t.string  :driving_license_number
    end
  end

  def down
    drop_table :users
  end
end
