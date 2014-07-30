class Sms < ActiveRecord::Base
  class << self
    def send_welcome(summons)
      Resque.enqueue(SendSms, summons.phone_number,
        %{Welcome to the Jury Duty Notifier. Reply with CANCEL at any time to stop notifications.}
      )
    end

    def cancel_request?(incoming_message)
      message = incoming_message.downcase
      message.include?('cancel') || message.include?('stop')
    end
  end
end
