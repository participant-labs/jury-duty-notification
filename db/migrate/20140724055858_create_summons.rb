class CreateSummons < ActiveRecord::Migration
  def change
    create_table :summons do |t|
      t.date :service_week, null: false
      t.integer :group_number, null: false
      t.text :phone_number, null: false
    end
    add_index :summons, :service_week
  end
end
