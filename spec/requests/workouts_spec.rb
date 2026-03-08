require 'rails_helper'

RSpec.describe "Workouts", type: :request do
  describe "GET /index" do
    let(:user) { create(:user) }
    let!(:workout_1) { create(:workout, user: user, date: Date.today) }
    let!(:workout_2) { create(:workout, user: user, date: 1.day.ago) }

    context 'when authenticated' do
      before { login_user(user) }

      it "returns http success" do
        get workouts_path
        expect(response).to have_http_status(:success)
      end

      it 'displays users workouts' do
        get workouts_path
        expect(response.body).to include(workout_1.date.strftime("%d.%m.%Y"))
        expect(response.body).to include(workout_2.date.strftime("%d.%m.%Y"))
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to root path' do
        get workouts_path
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
