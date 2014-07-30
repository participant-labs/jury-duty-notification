require 'current_week'

class Summons < ActiveRecord::Base
  belongs_to :canceled_by, class_name: 'Sms'

  validates_presence_of :service_week, :group_number, :phone_number

  validates_uniqueness_of :phone_number, scope: [:service_week, :group_number],
    message: 'has already been recorded for that week and group number!'

  validate :service_week_in_range

  scope :active, -> { where(canceled_by_id: nil) }
  scope :pending, -> { active.where('service_week >= ?', current_week)}
  scope :for_current_week, -> { where(service_week: current_week) }

  def phone_number=(number)
    number = E164.normalize(number) if number.present?
    self[:phone_number] = number
  end

  private

  def service_week_in_range
    return if service_week.blank?
    if service_week < current_week
      errors.add(:service_week, 'is too far in the past')
    elsif service_week > 2.months.since(current_week)
      errors.add(:service_week, 'is too far in the future')
    end
  end
end
