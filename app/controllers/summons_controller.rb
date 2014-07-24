class SummonsController < ApplicationController
  def new
    @summons = Summons.new
  end

  def create
    @summons = Summons.new(summons_params)
    if @summons.save
      flash.notice = "Great! We'll be texting you shortly to confirm your notification."
    elsif uniqueness_error?(@summons)
      # we use a notice because we already have this person on record
      flash.notice = @summons.errors.full_messages.to_sentence
    else
      flash.alert = @summons.errors.full_messages.to_sentence
    end
    redirect_to root_path
  end

  private

  def uniqueness_error?(summons)
    summons.errors.count == 1 && summons.errors[:phone_number].present? \
      && summons.errors[:phone_number].first.include?('has already been recorded')
  end

  def summons_params
    params.require(:summons).permit(:service_week, :group_number, :phone_number)
  end
end
