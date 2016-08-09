class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :password_digest, null: false
      t.string :session_token, null: false
      t.string :username, null: false
      t.timestamps null: false
    end

    add_index :users, :username
  end
end
