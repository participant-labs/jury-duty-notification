class SummonsController < ApplicationController
  def new
    @summons = Summons.new
  end

  def create
  end
end
