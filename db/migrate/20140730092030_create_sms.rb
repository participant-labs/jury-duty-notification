class CreateSms < ActiveRecord::Migration
  def change
    create_table :sms do |t|
      t.json :params, null: false

      t.timestamps
    end
    add_column :summons, :canceled_by_id, :integer
    add_foreign_key :summons, :sms, column: :canceled_by_id
  end
end
