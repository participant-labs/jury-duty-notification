require 'open-uri'

class NotifySummonedJurors
  @queue = :www_high

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
            groups_on_alert.detect do |group|
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
      # summons.for_current_week.unsummoned
      %w{101 112 602 605 616}
    end

    def notify(groups_to_notify, instruction)
      puts
      puts '*'*80
      puts
      puts "Notifying Groups: #{groups_to_notify}"
      puts
      puts "Message:"
      puts  instruction
      # groups_to_notify.each do |group|
      #   summoned_jurors = summons.for_current_week.where(group: group)
      #   summoned_jurors.each do |juror|
      #     Resque.enqueue(SendSms, from_phone, juror.phone, instruction)
      #   end
      # end
    end
  end

end
