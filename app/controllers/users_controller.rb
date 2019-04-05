class UsersController < ApplicationController
  before_filter :check_app_auth, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if @current_user_object.is_real_admin?
      @users = User
    else
      @users = User.where("(is_real_admin IS NULL OR is_real_admin = 0) AND user_login != 'test'")
    end
    if params.has_key?(:search)
      @users = @users.where("user_login ilike ?", "#{params['search']}%")
    end
    @users = @users.all  
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.is_real_admin = 0 if @current_user_object.blank? or !@current_user_object.is_real_admin?
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user.is_real_admin = 0 unless @current_user_object.is_real_admin?

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:user_login, :user_password, :email, 
        :is_real_admin, :hobbies)
    end
    
    def check_ctr_auth()
      return true if [:new, :create, :edit].include?(action_name.to_sym)
      return true if @current_user_object.is_real_admin?
      return true if [:index].include?(action_name.to_sym)
      if [:show].include?(action_name.to_sym)
        if @user.nil?
          set_user()
        end
        if @user.is_real_admin? == false and @user.user_login != 'test'
          return true   
        end
      end
      return false
    end  
end
