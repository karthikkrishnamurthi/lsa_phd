class LsaTestWordsController < ApplicationController
  # GET /lsa_test_words
  # GET /lsa_test_words.json
  def index
    @lsa_test_words = LsaTestWord.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lsa_test_words }
    end
  end

  # GET /lsa_test_words/1
  # GET /lsa_test_words/1.json
  def show
    @lsa_test_word = LsaTestWord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lsa_test_word }
    end
  end

  # GET /lsa_test_words/new
  # GET /lsa_test_words/new.json
  def new
    @lsa_test_word = LsaTestWord.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lsa_test_word }
    end
  end

  # GET /lsa_test_words/1/edit
  def edit
    @lsa_test_word = LsaTestWord.find(params[:id])
  end

  # POST /lsa_test_words
  # POST /lsa_test_words.json
  def create
    @lsa_test_word = LsaTestWord.new(params[:lsa_test_word])

    respond_to do |format|
      if @lsa_test_word.save
        format.html { redirect_to @lsa_test_word, notice: 'Lsa test word was successfully created.' }
        format.json { render json: @lsa_test_word, status: :created, location: @lsa_test_word }
      else
        format.html { render action: "new" }
        format.json { render json: @lsa_test_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lsa_test_words/1
  # PUT /lsa_test_words/1.json
  def update
    @lsa_test_word = LsaTestWord.find(params[:id])

    respond_to do |format|
      if @lsa_test_word.update_attributes(params[:lsa_test_word])
        format.html { redirect_to @lsa_test_word, notice: 'Lsa test word was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lsa_test_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lsa_test_words/1
  # DELETE /lsa_test_words/1.json
  def destroy
    @lsa_test_word = LsaTestWord.find(params[:id])
    @lsa_test_word.destroy

    respond_to do |format|
      format.html { redirect_to lsa_test_words_url }
      format.json { head :no_content }
    end
  end
end
