class UsersController < ApplicationController
  before_action :authenticate_user!, only: %I[show index update destroy]
  def index
    @users = User.all
  end
end
