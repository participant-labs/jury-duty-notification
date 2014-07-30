class AddTimestampsToSummons < ActiveRecord::Migration
  def change
    add_timestamps :summons
  end
end
