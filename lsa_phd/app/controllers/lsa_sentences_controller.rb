class LsaSentencesController < ApplicationController
  # GET /lsa_sentences
  # GET /lsa_sentences.json
  def index
    @lsa_sentences = LsaSentence.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lsa_sentences }
    end
  end

  # GET /lsa_sentences/1
  # GET /lsa_sentences/1.json
  def show
    @lsa_sentence = LsaSentence.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lsa_sentence }
    end
  end

  # GET /lsa_sentences/new
  # GET /lsa_sentences/new.json
  def new
    @lsa_sentence = LsaSentence.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lsa_sentence }
    end
  end

  # GET /lsa_sentences/1/edit
  def edit
    @lsa_sentence = LsaSentence.find(params[:id])
  end

  # POST /lsa_sentences
  # POST /lsa_sentences.json
  def create
    @lsa_sentence = LsaSentence.new(params[:lsa_sentence])

    respond_to do |format|
      if @lsa_sentence.save
        format.html { redirect_to @lsa_sentence, notice: 'Lsa sentence was successfully created.' }
        format.json { render json: @lsa_sentence, status: :created, location: @lsa_sentence }
      else
        format.html { render action: "new" }
        format.json { render json: @lsa_sentence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lsa_sentences/1
  # PUT /lsa_sentences/1.json
  def update
    @lsa_sentence = LsaSentence.find(params[:id])

    respond_to do |format|
      if @lsa_sentence.update_attributes(params[:lsa_sentence])
        format.html { redirect_to @lsa_sentence, notice: 'Lsa sentence was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lsa_sentence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lsa_sentences/1
  # DELETE /lsa_sentences/1.json
  def destroy
    @lsa_sentence = LsaSentence.find(params[:id])
    @lsa_sentence.destroy

    respond_to do |format|
      format.html { redirect_to lsa_sentences_url }
      format.json { head :no_content }
    end
  end
end
