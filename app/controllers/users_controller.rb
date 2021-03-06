class UsersController < ApplicationController
load_and_authorize_resource

  def index
    @students = User.where(role: :student).order(:last_name)
    @instructors = User.where(role: :instructor).order(:last_name)
    @admins = User.where(role: :admin).order(:last_name)
  end

  def new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to users_path, notice: "User has been successfully added."
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to(user_path(@user), notice: "#{@user.username} has been successfully updated.")
    else
      render action: 'edit'
    end
  end

  def destroy
    if session[:current_user_id] == params[:id].to_i
      User.destroy(params[:id])
      redirect_to(root_url, notice: "You have been removed.")
    else
      User.destroy(params[:id])
      redirect_to(users_path, notice: "User has been removed.")
    end
  end

end
