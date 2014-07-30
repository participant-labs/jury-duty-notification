require 'open-uri'

class NotifySummonedJurors
  @queue = :high

  JURY_INFO_URL = 'http://www.sfsuperiorcourt.org/divisions/jury-services/jury-reporting'
  GROUP_INSTRUCTION_CSS = '#mainContentWrap ul.square li'

  class << self
    def perform

      group_instructions.each do |instruction|

        if instruction.include? "you are instructed"
          # unless you are instructed, you have already been summoned
          # we still need a way to handle end of the week notification
          #   if you've never been summoned.

          groups_to_notify =
            groups_on_alert.select do |group|
              instruction.include? group
            end

          if groups_to_notify.present?
            notify(groups_to_notify, instruction)
          end

        end
      end
    end

    private

    def group_instructions
      page = Nokogiri::HTML(open(JURY_INFO_URL))
      page.css(GROUP_INSTRUCTION_CSS).map do |element|
        element.content.gsub(/\s/,' ').squish
      end
    end

    def groups_on_alert
      Summons.active.for_current_week.distinct.pluck(:group_number).map(&:to_s)
    end

    def notify(groups_to_notify, instruction)
      groups_to_notify.each do |group|
        summoned_jurors = Summons.for_current_week.where(group_number: group)
        summoned_jurors.each do |juror|
          Resque.enqueue(SendSms, juror.phone_number, instruction)
        end
      end
    end
  end

end
