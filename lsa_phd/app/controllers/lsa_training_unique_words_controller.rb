class LsaTrainingUniqueWordsController < ApplicationController
  # GET /lsa_training_unique_words
  # GET /lsa_training_unique_words.json
  def index
    @lsa_training_unique_words = LsaTrainingUniqueWord.find_all_by_lsa_document_id(params[:lsa_document_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lsa_training_unique_words }
    end
  end

  # GET /lsa_training_unique_words/1
  # GET /lsa_training_unique_words/1.json
  def show
    @lsa_training_unique_word = LsaTrainingUniqueWord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lsa_training_unique_word }
    end
  end

  # GET /lsa_training_unique_words/new
  # GET /lsa_training_unique_words/new.json
  def new
    @lsa_training_unique_word = LsaTrainingUniqueWord.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lsa_training_unique_word }
    end
  end

  # GET /lsa_training_unique_words/1/edit
  def edit
    @lsa_training_unique_word = LsaTrainingUniqueWord.find(params[:id])
  end

  # POST /lsa_training_unique_words
  # POST /lsa_training_unique_words.json
  def create
    @lsa_training_unique_word = LsaTrainingUniqueWord.new(params[:lsa_training_unique_word])

    respond_to do |format|
      if @lsa_training_unique_word.save
        format.html { redirect_to @lsa_training_unique_word, notice: 'Lsa training unique word was successfully created.' }
        format.json { render json: @lsa_training_unique_word, status: :created, location: @lsa_training_unique_word }
      else
        format.html { render action: "new" }
        format.json { render json: @lsa_training_unique_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lsa_training_unique_words/1
  # PUT /lsa_training_unique_words/1.json
  def update
    @lsa_training_unique_word = LsaTrainingUniqueWord.find(params[:id])

    respond_to do |format|
      if @lsa_training_unique_word.update_attributes(params[:lsa_training_unique_word])
        format.html { redirect_to @lsa_training_unique_word, notice: 'Lsa training unique word was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lsa_training_unique_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lsa_training_unique_words/1
  # DELETE /lsa_training_unique_words/1.json
  def destroy
    @lsa_training_unique_word = LsaTrainingUniqueWord.find(params[:id])
    @lsa_training_unique_word.destroy

    respond_to do |format|
      format.html { redirect_to lsa_training_unique_words_url }
      format.json { head :no_content }
    end
  end
end
