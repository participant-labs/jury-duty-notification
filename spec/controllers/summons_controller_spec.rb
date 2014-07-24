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
    def send_request
      post :create, summons: params
    end

    let(:service_week) { 1.week.from_now }
    let(:group_number) { rand(999) }
    let(:phone_number) { Faker::PhoneNumber.phone_number }
    let(:params) {
      {
        service_week: service_week,
        group_number: group_number,
        phone_number: phone_number
      }
    }

    shared_examples_for 'summons success' do
      it 'creates the summons' do
        expect { send_request }.to change(Summons, :count).by(1)
        expect(response).to redirect_to(root_path)
        expect(flash.notice).to be_present
      end
    end

    shared_examples_for 'summons failure' do
      it 'fails' do
        expect { send_request }.to_not change(Summons, :count)
        expect(response).to redirect_to(root_path)
        expect(flash.alert).to be_present
      end
    end

    context 'with the required params' do
      it_behaves_like 'summons success'
    end

    context 'with a uniqueness violation' do
      before do
        Summons.create!(params)
      end

      # doesn't behave like summons failure because the person is already registered
      it "tells the user they're already registered" do
        expect { send_request }.to_not change(Summons, :count)
        expect(response).to redirect_to(root_path)
        expect(flash.notice).to be_present
      end
    end

    context 'with a missing phone number' do
      let(:phone_number) { '' }

      it_behaves_like 'summons failure'
    end

    context 'with a missing group number' do
      let(:group_number) { '' }

      it_behaves_like 'summons failure'
    end

    context 'with a service week' do
      context 'missing' do
        let(:service_week) { '' }

        it_behaves_like 'summons failure'
      end

      context 'more than a week past' do
        let(:service_week) { 8.days.ago }

        it_behaves_like 'summons failure'
      end

      context 'less than a week past' do
        let(:service_week) { 3.days.ago }

        it_behaves_like 'summons success'
      end

      context 'less than two months in the future' do
        let(:service_week) { 3.weeks.from_now }

        it_behaves_like 'summons success'
      end

      context 'two months in the future' do
        let(:service_week) { 2.months.from_now }

        it_behaves_like 'summons failure'
      end
    end
  end
end
