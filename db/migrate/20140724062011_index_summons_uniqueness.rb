class IndexSummonsUniqueness < ActiveRecord::Migration
  def change
    add_index :summons, [:service_week, :group_number, :phone_number],
      unique: true
    remove_index :summons, :service_week # this is covered by the above
  end
end
