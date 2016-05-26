class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.string :key
      t.string :email
      t.integer :sends_week, default: 0
      t.integer :sends_all, default: 0

      t.timestamps null: false
    end
  end
end
