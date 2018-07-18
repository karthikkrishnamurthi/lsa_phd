class LsaWordsController < ApplicationController
  # GET /lsa_words
  # GET /lsa_words.json
  def index
    @lsa_words = LsaWord.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lsa_words }
    end
  end

  # GET /lsa_words/1
  # GET /lsa_words/1.json
  def show
    @lsa_word = LsaWord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lsa_word }
    end
  end

  # GET /lsa_words/new
  # GET /lsa_words/new.json
  def new
    @lsa_word = LsaWord.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lsa_word }
    end
  end

  # GET /lsa_words/1/edit
  def edit
    @lsa_word = LsaWord.find(params[:id])
  end

  # POST /lsa_words
  # POST /lsa_words.json
  def create
    @lsa_word = LsaWord.new(params[:lsa_word])

    respond_to do |format|
      if @lsa_word.save
        format.html { redirect_to @lsa_word, notice: 'Lsa word was successfully created.' }
        format.json { render json: @lsa_word, status: :created, location: @lsa_word }
      else
        format.html { render action: "new" }
        format.json { render json: @lsa_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lsa_words/1
  # PUT /lsa_words/1.json
  def update
    @lsa_word = LsaWord.find(params[:id])

    respond_to do |format|
      if @lsa_word.update_attributes(params[:lsa_word])
        format.html { redirect_to @lsa_word, notice: 'Lsa word was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lsa_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lsa_words/1
  # DELETE /lsa_words/1.json
  def destroy
    @lsa_word = LsaWord.find(params[:id])
    @lsa_word.destroy

    respond_to do |format|
      format.html { redirect_to lsa_words_url }
      format.json { head :no_content }
    end
  end
end
