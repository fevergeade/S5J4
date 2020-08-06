class GossipsController < ApplicationController
  before_action :set_gossip, only: [:show, :edit, :update, :destroy]

  # GET /gossips
  # GET /gossips.json
  def index
    @gossips = Gossip.all
  end

  # GET /gossips/1
  # GET /gossips/1.json
  def show
    @comments = set_gossip_comments(@gossip)
    @tags = JoinTableGossipTag.where(gossip_id: @gossip.id)
    @comment = Comment.new
  end

  # GET /gossips/new
  def new
    @gossip = Gossip.new
    @tag_selected = []
    @tags = Tag.all
  end

  # GET /gossips/1/edit
  def edit
    @tags = Tag.all
    @gossip = Gossip.find(params[:id])
    @current_tags = JoinTableGossipTag.all.map{|join| join.gossip_id == @gossip.id ? join.tag_id : nil}.compact
  end

  # POST /gossips
  # POST /gossips.json
  def create
    @gossip = Gossip.new(gossip_params)
    @tags = Tag.all
    @tag_selected =params[:@tag_selected]
    respond_to do |format|
      if @gossip.save
        @tag_selected.each do |tag|
          JoinTableGossipTag.create(gossip_id: @gossip.id,tag_id: tag)
        end
        format.html { redirect_to @gossip, notice: 'Gossip was successfully created.' }
        format.json { render :show, status: :created, location: @gossip }
      else
        format.html { render :new }
        format.json { render json: @gossip.errors, status: :unprocessable_entity }
      end
    end
    puts @gossip.errors.messages
  end

  # PATCH/PUT /gossips/1
  # PATCH/PUT /gossips/1.json
  def update

    @tags = Tag.all
    @gossip = Gossip.find(params[:id])
    @current_tags = JoinTableGossipTag.all.map{|join| join.gossip_id == @gossip.id ? join.tag_id : nil}.compact
    @tag_selected =params[:@tag_selected]
    respond_to do |format|
      if @gossip.update(gossip_params)
        @tags.each do |tags|
          if @current_tags.index(tags.id)!=nil && @tag_selected.index(tags.id.to_s)==nil
            puts "je detruit"
            JoinTableGossipTag.find_by(gossip_id: @gossip.id,tag_id: tags.id).destroy
          elsif @current_tags.index(tags.id)==nil && @tag_selected.index(tags.id.to_s)!=nil
            puts "j'ajoute"
            JoinTableGossipTag.create(gossip_id: @gossip.id,tag_id: tags.id)
          end
        end
        format.html { redirect_to @gossip, notice: 'Gossip was successfully updated.' }
        format.json { render :show, status: :ok, location: @gossip }
      else
        format.html { render :edit }
        format.json { render json: @gossip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gossips/1
  # DELETE /gossips/1.json
  def destroy
    @current_tags = JoinTableGossipTag.all.map{|join| join.gossip_id == @gossip.id ? join.tag_id : nil}.compact
    @current_tags.each do |tags|
      JoinTableGossipTag.find_by(gossip_id: @gossip.id,tag_id: tags).destroy
    end
    @current_comment = set_gossip_comments(@gossip)
    @current_comment.each do |comment|
      comment.destroy
    end
    @gossip.destroy
    respond_to do |format|
      format.html { redirect_to gossips_url, notice: 'Gossip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gossip
      @gossip = Gossip.find(params[:id])
    end
    # retourn la liste des commentaires.
    def set_gossip_comments(gossip)
      @comments = gossip.comments
    end
    # Only allow a list of trusted parameters through.
    def gossip_params
      params.require(:gossip).permit(:title, :content, :user_id)
    end
end
