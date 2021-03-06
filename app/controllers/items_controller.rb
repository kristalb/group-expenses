class ItemsController < ApplicationController
  # GET /items
  # GET /items.xml
  
  before_filter :require_user
  
  def index
    @users = User.find(:all)
    @user = current_user
    
    if params[:type]
      @type = Type.find_by_name(params[:type])
      @items = Item.find_all_by_type_id(@type, :order => "date DESC")
    elsif params[:login]
      @items = Item.find_all_by_user_id(User.find_by_login(params[:login]))
    else
      @items = Item.all(:order => "date DESC")
    end

    @item = Item.new
    
    @types = Type.all
        
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.xml
  def create
    
    if params[:item][:type_id].split("_")[0] == "0" then
      params[:item][:given_to_id] = params[:item][:type_id].split("_")[1]
      params[:item][:type_id] = nil
    end
                
    @item = Item.new(params[:item])
    @item.user_id = current_user.id

    respond_to do |format|
      if @item.save
        flash[:notice] = 'Item was successfully created.'
        format.html { redirect_to(items_url) }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        flash[:notice] = 'Item was successfully updated.'
        format.html { redirect_to(items_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
    end
  end
  
  # Gather items for display in RSS feed
  def feed
    @items = Item.find(:all, :order => "date DESC")
    
    respond_to do |format|
      format.html
      format.rss  { render :layout => false }
    end
  end
end
