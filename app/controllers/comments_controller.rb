class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :check_logged
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new

  end

  # GET /comments/1/edit
  def edit
    if session[:user_id] != nil ? true : false
      @comment = Comment.find(params[:id])
    else
      redirect_to new_sessions_controller_path
    end 
  end

  # POST /comments
  # POST /comments.json
  def create
    if session[:user_id] != nil ? true : false
      @comment = Comment.new(comment_params)
      respond_to do |format|
        if @comment.save
          format.html {redirect_to gossip_path(params[:comment][:gossip_id]) }
          #format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
          #format.json { render :show, status: :created, location: @comment }
        else
          format.html { render :new }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_sessions_controller_path
    end 
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    gossip_id = @comment.gossip_id
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to gossip_path(gossip_id) }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    gossip_id = @comment.gossip_id
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to gossip_path(gossip_id) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content, :user_id, :gossip_id)
    end

    def check_logged
      if session[:user_id] == nil ? true : false
        redirect_to new_sessions_controller_path
      end
    end
end
