class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  # GET /users
  def index
    @users = User.all

    respond_to do |format|
      format.html
    end
  end

  def new 

  end

  # GET /users/1
  def show
    respond_to do |format|
      format.html
    end
  end

  # GET /users/1/edit
  def edit
    respond_to do |format|
      format.html
    end
  end

  # PATCH/PUT /users/1
  def update
    @user.assign_attributes(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy

    respond_to do |format|
      if @user.destroyed?
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      else
        format.html { redirect_to users_url @user, notice: 'Unable to delete user.' }
      end
    end
  end

  # POST /user/1/toggle_active
  def toggle_active
    @users = User.all

    respond_to do |format|
      if @user.toggle_active_status
        format.html { redirect_to users_url, notice: 'User de-activated' }
        format.js
      else
        format.html { redirect_to users_url, notice: 'Unable to change user status' }
        format.js { @error = 'Unable to change status' }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    end
end
