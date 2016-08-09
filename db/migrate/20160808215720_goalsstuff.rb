class Goalsstuff < ActiveRecord::Migration
  def change
    add_column :goals, :title, :string, null: false
    add_column :goals, :description, :text, null: false
    add_column :goals, :private, :string, null: false
    add_column :goals, :status, :string, null: false
    add_column :goals, :user_id, :integer, null: false

    add_index :goals, :user_id
  end
end
