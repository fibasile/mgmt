class UsersController < ApplicationController

  skip_before_filter :check_invitation, only: [:invite, :update]

  def invite
    session[:user_id] = nil
    if @user = User.where(invitation_code: params[:invitation_code]).first
      session[:user_id] = @user.id
      render :invite
    else
      render text: "User not found. Have you already completed the invitation request?"
    end
  end

  def update
    @user = current_user
    @user.update_attributes user_params
    if @user.save
      @user.update_attribute :invitation_code, nil
      redirect_to root_path, notice: 'Details updated successfully'
    else
      render @user.invitation_code.blank? ? :edit : :invite
    end
  end

private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :country_code,
      :photo,
      :description,
      :dob,
      :gender
    )
  end

end
