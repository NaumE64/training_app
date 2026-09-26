# users controller logic
class UsersController < ApplicationController
  include BCrypt

  def dashboard
    today_food_entries = current_user.food_entries.where(date: Date.today)
    @today_calories = today_food_entries.sum(&:calories)
    @today_proteins = today_food_entries.sum(&:proteins)
    @today_fats = today_food_entries.sum(&:fats)
    @today_carbs = today_food_entries.sum(&:carbs)
    redirect_to users_finish_profile_path if current_user.age.blank?

    @user = current_user
  end

  def finish_profile; end

  def finish_user_profile
    user = current_user
    user.update(
      age: params[:age],
      gender: params[:gender]
    )
    redirect_to users_dashboard_path
  end

  def forget_password; end

  def profile; end

  def update_profile
    if update_user_profile
      flash[:success] = I18n.t('success_messages.profile_updated')
      redirect_to users_profile_path
    else
      @errors = current_user.errors.full_messages
      render 'profile'
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :age, :avatar)
  end

  def change_password; end

  def update_password
    Users::UpdatePasswordService.new(
      user: current_user,
      old_password: params[:old_password],
      new_password: params[:new_password],
      new_password_confirmation: params[:new_password_confirmation]
    ).call
    redirect_to users_dashboard_path
  rescue ServiceError => e
    flash.now[:error] = e.message
    render 'change_password'
  end
end
