class AddIndexToKeys < ActiveRecord::Migration
  def change
    add_index :keys, :email, unique: true
  end
end
