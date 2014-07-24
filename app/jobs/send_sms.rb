class SendSms
  @queue = :high

  class << self
    def perform(from, to, body)
      twilio_client.account.messages.create(from: from, to: to, body: body)
    end

    private

    def twilio_client
      @twilio_client ||= Twilio::REST::Client.new TWILIO_ACCOUNT, TWILIO_PASSWORD
    end
  end

end
