class TransfersController < ApplicationController
  # GET /transfers
  # GET /transfers.xml
  def index
    @transfers = Transfers.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @transfers }
    end
  end

  # GET /transfers/1
  # GET /transfers/1.xml
  def show
    @transfers = Transfers.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @transfers }
    end
  end

  # GET /transfers/new
  # GET /transfers/new.xml
  def new
    @transfers = Transfers.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @transfers }
    end
  end

  # GET /transfers/1/edit
  def edit
    @transfers = Transfers.find(params[:id])
  end

  # POST /transfers
  # POST /transfers.xml
  def create
    @transfers = Transfers.new(params[:transfers])

    respond_to do |format|
      if @transfers.save
        flash[:notice] = 'Transfers was successfully created.'
        format.html { redirect_to(@transfers) }
        format.xml  { render :xml => @transfers, :status => :created, :location => @transfers }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @transfers.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /transfers/1
  # PUT /transfers/1.xml
  def update
    @transfers = Transfers.find(params[:id])

    respond_to do |format|
      if @transfers.update_attributes(params[:transfers])
        flash[:notice] = 'Transfers was successfully updated.'
        format.html { redirect_to(@transfers) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @transfers.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /transfers/1
  # DELETE /transfers/1.xml
  def destroy
    @transfers = Transfers.find(params[:id])
    @transfers.destroy

    respond_to do |format|
      format.html { redirect_to(transfers_url) }
      format.xml  { head :ok }
    end
  end
end
