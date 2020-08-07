class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @cities = City.all
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    post_params = params.require(:user).permit(:last_name, :first_name, :age, :description, :email, :password_digest, :city_id )
    puts post_params
      @cities = City.all
      @user = User.new(
          first_name: post_params[:first_name], 
          last_name: post_params[:last_name], 
          description: post_params[:description],
          email: post_params[:email],
          password: post_params[:password_digest], 
          age: post_params[:age].to_i,
          city_id: post_params[:city_id].to_i
        )
      respond_to do |format|
        if @user.save
          format.html { redirect_to root_path, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        else
          puts @user.errors.messages
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        puts 
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

    # Only allow a list of trusted parameters through.
    def user_params
      puts "user_params"
      puts params

      params.require(:user).permit(:last_name, :first_name, :age, :description, :email, :password_digest, :city_id )
      puts "apres"
      puts params

    end
end
