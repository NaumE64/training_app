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

  describe "GET /show" do
    let(:user) { create(:user) }
    let!(:workout) { create(:workout, user: user, date: Date.today) }

    before { login_user(user) }

    context 'when workout not exist' do
      it 'redirects to workouts path' do
        non_id = Workout.maximum(:id).to_i + 1
        get workout_path(id: non_id)
        expect(response).to redirect_to(workouts_path)
      end
    end

    context 'when workout exist' do
      it 'redirects to workout page' do
        get workout_path(id: workout.id)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'POST /create' do
    let(:user) { create(:user) }
    let(:workout_type) { create(:workout_type) }

    before { login_user(user) }

    context 'with valid params' do
      let(:valid_params) do
        { workout: { workout_type_id: workout_type.id, date: Date.today } }
      end

      it 'creates new workout' do
        expect {
          post workouts_path, params: valid_params
      }.to change(Workout, :count).by(1)
      expect(response).to redirect_to(users_dashboard_path)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        { workout: { workout_type_id: nil, date: nil } }
      end

      it 'does not create workout' do
        expect {
          post workouts_path, params: invalid_params
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'PUT /update' do
    let(:user) { create(:user) }
    let(:workout_type) { create(:workout_type) }
    let(:workout) { create(:workout, user: user, workout_type: workout_type, date: Date.today) }

    before { login_user(user) }

    context 'with valid params' do
      let(:valid_params) do
        { workout: { workout_type_id: workout_type.id, date: 1.day.ago } }
      end

      it 'updates workout' do
        put workout_path(id: workout.id), params: valid_params
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(users_dashboard_path)

        workout.reload
        expect(workout.date).to eq(1.day.ago.to_date)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        { workout: { workout_type_id: nil, date: nil } }
      end

      it 'does not update workout' do
        put workout_path(id: workout.id), params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
