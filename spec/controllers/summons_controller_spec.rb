require 'rails_helper'

describe SummonsController do
  describe 'GET new' do
    render_views

    it 'renders' do
      get :new
      expect(response).to be_success
    end
  end

  describe 'POST create' do
  end
end
