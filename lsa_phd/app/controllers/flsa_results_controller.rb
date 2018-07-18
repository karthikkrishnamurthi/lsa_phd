class FlsaResultsController < ApplicationController
  # GET /flsa_results
  # GET /flsa_results.json
  def index
    @flsa_results = FlsaResult.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @flsa_results }
    end
  end

  # GET /flsa_results/1
  # GET /flsa_results/1.json
  def show
    @flsa_result = FlsaResult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @flsa_result }
    end
  end

  # GET /flsa_results/new
  # GET /flsa_results/new.json
  def new
    @flsa_result = FlsaResult.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @flsa_result }
    end
  end

  # GET /flsa_results/1/edit
  def edit
    @flsa_result = FlsaResult.find(params[:id])
  end

  # POST /flsa_results
  # POST /flsa_results.json
  def create
    @flsa_result = FlsaResult.new(params[:flsa_result])

    respond_to do |format|
      if @flsa_result.save
        format.html { redirect_to @flsa_result, notice: 'Flsa result was successfully created.' }
        format.json { render json: @flsa_result, status: :created, location: @flsa_result }
      else
        format.html { render action: "new" }
        format.json { render json: @flsa_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /flsa_results/1
  # PUT /flsa_results/1.json
  def update
    @flsa_result = FlsaResult.find(params[:id])

    respond_to do |format|
      if @flsa_result.update_attributes(params[:flsa_result])
        format.html { redirect_to @flsa_result, notice: 'Flsa result was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @flsa_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flsa_results/1
  # DELETE /flsa_results/1.json
  def destroy
    @flsa_result = FlsaResult.find(params[:id])
    @flsa_result.destroy

    respond_to do |format|
      format.html { redirect_to flsa_results_url }
      format.json { head :no_content }
    end
  end
end
