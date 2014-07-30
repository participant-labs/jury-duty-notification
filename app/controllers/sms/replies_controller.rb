class Sms::RepliesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    sms = Sms.create!(params: params)
    if Sms.cancel_request?(params[:Body])
      number = E164.normalize(params[:From])
      Summons.pending.where(phone_number: number).update_all(cancelled_by_id: sms)
    end
  end
end
