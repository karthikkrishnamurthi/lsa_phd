class LsaTestSentencesController < ApplicationController
  # GET /lsa_test_sentences
  # GET /lsa_test_sentences.json
  def index
    @lsa_test_sentences = LsaTestSentence.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lsa_test_sentences }
    end
  end

  # GET /lsa_test_sentences/1
  # GET /lsa_test_sentences/1.json
  def show
    @lsa_test_sentence = LsaTestSentence.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lsa_test_sentence }
    end
  end

  # GET /lsa_test_sentences/new
  # GET /lsa_test_sentences/new.json
  def new
    @lsa_test_sentence = LsaTestSentence.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lsa_test_sentence }
    end
  end

  # GET /lsa_test_sentences/1/edit
  def edit
    @lsa_test_sentence = LsaTestSentence.find(params[:id])
  end

  # POST /lsa_test_sentences
  # POST /lsa_test_sentences.json
  def create
    @lsa_test_sentence = LsaTestSentence.new(params[:lsa_test_sentence])

    respond_to do |format|
      if @lsa_test_sentence.save
        format.html { redirect_to @lsa_test_sentence, notice: 'Lsa test sentence was successfully created.' }
        format.json { render json: @lsa_test_sentence, status: :created, location: @lsa_test_sentence }
      else
        format.html { render action: "new" }
        format.json { render json: @lsa_test_sentence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lsa_test_sentences/1
  # PUT /lsa_test_sentences/1.json
  def update
    @lsa_test_sentence = LsaTestSentence.find(params[:id])

    respond_to do |format|
      if @lsa_test_sentence.update_attributes(params[:lsa_test_sentence])
        format.html { redirect_to @lsa_test_sentence, notice: 'Lsa test sentence was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lsa_test_sentence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lsa_test_sentences/1
  # DELETE /lsa_test_sentences/1.json
  def destroy
    @lsa_test_sentence = LsaTestSentence.find(params[:id])
    @lsa_test_sentence.destroy

    respond_to do |format|
      format.html { redirect_to lsa_test_sentences_url }
      format.json { head :no_content }
    end
  end
end
