class Summons < ActiveRecord::Base
  validates_presence_of :service_week, :group_number, :phone_number

  validates_uniqueness_of :phone_number, scope: [:service_week, :group_number],
    message: 'has already been recorded for that week and group number!'

  validate :service_week_in_range

  private

  def service_week_in_range
    return if service_week.blank?
    if service_week < current_week
      errors.add(:service_week, 'is too far in the past')
    elsif service_week > 2.months.since(current_week)
      errors.add(:service_week, 'is too far in the future')
    end
  end

  def current_week
    Date.current.beginning_of_week
  end
end
