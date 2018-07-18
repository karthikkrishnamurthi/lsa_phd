# encoding: UTF-8
require 'linalg'
include Linalg
class DocumentsController < ApplicationController
  def index
    @documents = Document.all(:order => 'id desc')
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
    @document = Document.new
  end

  def edit
    @document = Document.find(params[:id])
  end

  def create_sentences
    documents = Document.all
    j = 1
    documents.each do |d|
      c = d.content.gsub!(/\s+/," ") # replace multiple spaces with single space
      sentences = c.split(".")
      i = 1
      sentences.each do |s|
        unless i == 1
          s[0] = ""
        end
        sen = Sentence.new
        sen.sentence = s
        sen.document_id = d.id
        sen.save
        i = i + 1
      end
      puts "Created #{i.inspect} sentences for document #{j.inspect}"
      j = j + 1
    end
    @sentences = Sentence.all
  end

  def create_words
    # ENGLISH STOPWORD LIST
    sw = ["a","abl","about","abov","accord","accordingli","across","actual","after","afterward","again","against","all","allow","allow","almost","alon","along","alreadi","also","although","alway","am","among","amongst","an","and","anoth","ani","anybodi","anyhow","anyon","anyth","anyway","anyway","anywher","apart","appear","appreci","appropri","are","around","as","asid","ask","ask","associ","at","avail","away","aw","b","be","becam","becaus","becom","becom","becom","been","befor","beforehand","behind","be","believ","below","besid","besid","best","better","between","beyond","both","brief","but","by","c","came","can","cannot","cant","caus","caus","certain","certainli","chang","clearli","co","com","come","come","concern","consequ","consid","consid","contain","contain","contain","correspond","could","couldnt","cours","current","d","definit","describ","despit","did","didnt","differ","do","doe","doesnt","do","dont","done","down","downward","dure","e","each","edu","eg","eight","either","els","elsewher","enough","entir","especi","et","etc","even","ever","everi","everybodi","everyon","everyth","everywher","ex","exactli","exampl","except","f","far","few","fifth","first","five","follow","follow","follow","for","former","formerli","forth","four","from","further","furthermor","g","get","get","get","given","give","go","goe","go","gone","got","gotten","greet","h","had","hadnt","happen","hardli","ha","hasnt","have","havent","have","he","hes","hello","help","henc","her","here","heres","hereaft","herebi","herein","hereupon","her","herself","hi","him","himself","hi","hither","hope","how","howbeit","howev","i","id","ill","im","ive","ie","if","ignor","immedi","in","inasmuch","inc","inde","indic","indic","indic","inner","insofar","instead","into","inward","is","isnt","it","itd","itll","its","it","itself","j","just","k","keep","keep","kept","know","know","known","l","last","late","later","latter","latterli","least","less","lest","let","lets","like","like","like","littl","look","look","look","ltd","m","mainli","mani","may","mayb","me","mean","meanwhil","mere","might","more","moreov","most","mostli","much","must","my","myself","n","name","name","nd","near","nearli","necessari","need","need","neither","never","nevertheless","new","next","nine","no","nobodi","non","none","noon","nor","normal","not","noth","novel","now","nowher","o","obvious","of","off","often","oh","ok","okay","old","on","onc","one","one","onli","onto","or","other","other","otherwis","ought","our","our","ourselv","out","outsid","over","overal","own","p","particular","particularli","per","perhap","place","pleas","plu","possibl","presum","probabl","provid","q","que","quit","qv","r","rather","rd","re","realli","reason","regard","regardless","regard","rel","respect","right","s","said","same","saw","say","say","say","second","secondli","see","see","seem","seem","seem","seem","seen","self","selv","sensibl","sent","seriou","serious","seven","sever","shall","she","should","shouldnt","sinc","six","so","some","somebodi","somehow","someon","someth","sometim","sometim","somewhat","somewher","soon","sorri","specifi","specifi","specifi","still","sub","such","sup","sure","t","ts","take","taken","tell","tend","th","than","thank","thank","thanx","that","thats","that","the","their","their","them","themselv","then","thenc","there","theres","thereaft","therebi","therefor","therein","there","thereupon","these","they","theyd","theyll","theyre","theyve","think","third","thi","thorough","thoroughli","those","though","three","through","throughout","thru","thu","to","togeth","too","took","toward","toward","tri","tri","truli","tri","tri","twice","two","u","un","under","unfortun","unless","unlik","until","unto","up","upon","us","use","use","use","use","use","usual","uucp","v","valu","variou","veri","via","viz","vs","w","want","want","wa","wasnt","way","we","wed","well","were","weve","welcom","well","went","were","werent","what","whats","whatev","when","whenc","whenev","where","wheres","whereaft","wherea","wherebi","wherein","whereupon","wherev","whether","which","while","whither","who","whos","whoever","whole","whom","whose","whi","will","will","wish","with","within","without","wont","wonder","would","would","wouldnt","x","y","ye","yet","you","youd","youll","youre","youve","your","your","yourself","yourselv","z","zero"]
    i = 1
    sentences = Sentence.all #(:conditions => "id > 118204")
    sentences.each do |sentence|
      s = sentence.sentence
      unless s.scan("-").nil? or s.scan("-").blank? then
        s = s.gsub!("-"," ")
      end
      unless s.scan(/\d+/).nil? or s.scan(/\d+/).blank? then
        s = s.gsub!(/\d+/," ")
      end
      unless s.scan(/\w+/).nil? or s.scan(/\w+/).blank? then
        s = s.gsub!(/\w+/," ")
      end
      s = s.gsub!(/\s+/," ")
      s = s.split(" ")
      s = s - sw
      s.each do |t|
        w = Word.new
        w.word = t
        w.sentence_id = sentence.id
        w.document_id = sentence.document_id
        w.save
      end
      puts "--------------- Created words for sentence #{i.inspect} ---------------"
      i = i + 1
    end
  end

  def create
    # d = params[:document][:content]
    File.open("/home/karthik/Documents/lsa/male.txt", "r").each_line do |d|
      d = d.delete(",")
      d = d.delete("'")
      d = d.delete("”")
      d = d.delete("“")
      d = d.delete("’’")
      d = d.delete("‘’")
      d = d.delete("-")
      d = d.delete("—")
      d = d.delete("?")
      d = d.delete("%")
      d = d.delete("!")
      d = d.delete("&")
      d = d.delete("$")
      d = d.delete(":")
      d = d.delete(";")
      d = d.delete("*")
      d = d.delete("@")
      d = d.delete("(")
      d = d.delete(")")
      d = d.delete("]")
      d = d.delete("[")
      d = d.delete("\/")
      d = d.delete("\#")
      d = d.delete("\"")
      d = d.delete("\r\n")
      @document = Document.new
      @document.content = d
      @document.label = "male"
      @document.save
      @document.content.split(".").each do |s|
        sen = Sentence.new
        sen.sentence = s
        sen.document_id = @document.id
        sen.save
      end

      # ENGLISH STOPWORD LIST
      sw = ["a","abl","about","abov","accord","accordingli","across","actual","after","afterward","again","against","all","allow","allow","almost","alon","along","alreadi","also","although","alway","am","among","amongst","an","and","anoth","ani","anybodi","anyhow","anyon","anyth","anyway","anyway","anywher","apart","appear","appreci","appropri","are","around","as","asid","ask","ask","associ","at","avail","away","aw","b","be","becam","becaus","becom","becom","becom","been","befor","beforehand","behind","be","believ","below","besid","besid","best","better","between","beyond","both","brief","but","by","c","came","can","cannot","cant","caus","caus","certain","certainli","chang","clearli","co","com","come","come","concern","consequ","consid","consid","contain","contain","contain","correspond","could","couldnt","cours","current","d","definit","describ","despit","did","didnt","differ","do","doe","doesnt","do","dont","done","down","downward","dure","e","each","edu","eg","eight","either","els","elsewher","enough","entir","especi","et","etc","even","ever","everi","everybodi","everyon","everyth","everywher","ex","exactli","exampl","except","f","far","few","fifth","first","five","follow","follow","follow","for","former","formerli","forth","four","from","further","furthermor","g","get","get","get","given","give","go","goe","go","gone","got","gotten","greet","h","had","hadnt","happen","hardli","ha","hasnt","have","havent","have","he","hes","hello","help","henc","her","here","heres","hereaft","herebi","herein","hereupon","her","herself","hi","him","himself","hi","hither","hope","how","howbeit","howev","i","id","ill","im","ive","ie","if","ignor","immedi","in","inasmuch","inc","inde","indic","indic","indic","inner","insofar","instead","into","inward","is","isnt","it","itd","itll","its","it","itself","j","just","k","keep","keep","kept","know","know","known","l","last","late","later","latter","latterli","least","less","lest","let","lets","like","like","like","littl","look","look","look","ltd","m","mainli","mani","may","mayb","me","mean","meanwhil","mere","might","more","moreov","most","mostli","much","must","my","myself","n","name","name","nd","near","nearli","necessari","need","need","neither","never","nevertheless","new","next","nine","no","nobodi","non","none","noon","nor","normal","not","noth","novel","now","nowher","o","obvious","of","off","often","oh","ok","okay","old","on","onc","one","one","onli","onto","or","other","other","otherwis","ought","our","our","ourselv","out","outsid","over","overal","own","p","particular","particularli","per","perhap","place","pleas","plu","possibl","presum","probabl","provid","q","que","quit","qv","r","rather","rd","re","realli","reason","regard","regardless","regard","rel","respect","right","s","said","same","saw","say","say","say","second","secondli","see","see","seem","seem","seem","seem","seen","self","selv","sensibl","sent","seriou","serious","seven","sever","shall","she","should","shouldnt","sinc","six","so","some","somebodi","somehow","someon","someth","sometim","sometim","somewhat","somewher","soon","sorri","specifi","specifi","specifi","still","sub","such","sup","sure","t","ts","take","taken","tell","tend","th","than","thank","thank","thanx","that","thats","that","the","their","their","them","themselv","then","thenc","there","theres","thereaft","therebi","therefor","therein","there","thereupon","these","they","theyd","theyll","theyre","theyve","think","third","thi","thorough","thoroughli","those","though","three","through","throughout","thru","thu","to","togeth","too","took","toward","toward","tri","tri","truli","tri","tri","twice","two","u","un","under","unfortun","unless","unlik","until","unto","up","upon","us","use","use","use","use","use","usual","uucp","v","valu","variou","veri","via","viz","vs","w","want","want","wa","wasnt","way","we","wed","well","were","weve","welcom","well","went","were","werent","what","whats","whatev","when","whenc","whenev","where","wheres","whereaft","wherea","wherebi","wherein","whereupon","wherev","whether","which","while","whither","who","whos","whoever","whole","whom","whose","whi","will","will","wish","with","within","without","wont","wonder","would","would","wouldnt","x","y","ye","yet","you","youd","youll","youre","youve","your","your","yourself","yourselv","z","zero"]
      
      @document.sentences.each do |sentence|
        sentence.sentence.gsub!("-"," ")
        regex = /\d+/             # regular expression to match digits
        numbers_in_sentence = sentence.sentence.scan(regex)
        numbers_in_sentence.each do |n|
          sentence.sentence.slice!(n)
        end

        s = sentence.sentence.split(" ")
        s = s - sw

        s.each do |t|
          w = Word.new
          w.word = t.downcase
          w.sentence_id = sentence.id
          w.document_id = @document.id
          w.save
        end
      end
    end
    redirect_to "/documents/sentences/#{@document.id}"
  end

  def seperate_by_space
    documents = Document.all
    i = 1
    documents.each do |d|
      content = d.content.gsub!(".",". ")
      content = content.gsub!(/\s+/," ")
      d.update_column(:content, content)
      puts "Document #{i.inspect} completed..."
      i = i + 1
    end    
  end

  def remove_ending_space
    documents = Document.all
    i = 1
    documents.each do |d|
      content = d.content
      last = content.length - 1
      content[last] = ""
      d.update_column(:content, content)
      puts "Document #{i.inspect} completed..."
      i = i + 1
    end      
  end

  def update
    @document = Document.find(params[:id])
    @document.update_attributes(params[:document])
    redirect_to @document
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to documents_url
  end

  def tf_matrix
    documents = Document.all
    i = 1
    documents.each do |d|
      all_words = Word.find_all_by_document_id(d.id).collect(&:word).uniq
      word_count = Array.new
      document_matrix = ""
      all_words.each do |w|
        word_count = []
        d.sentences.each do |s|
          words_in_s = s.words.collect(&:word)
          tf = words_in_s.count(w)
          word_count << tf
        end
        wc = word_count.to_s
        wc = wc.delete("[")
        wc = wc.delete("]")
        document_matrix << "|"
        document_matrix << wc
      end
      document_matrix[0] = ""
      d.update_column(:matrix,document_matrix)
      puts "Created matrix for document #{i.inspect}"
      i = i + 1
    end
  end

  def augmented_tf_matrix
    all_words = Word.find_all_by_document_id(params[:id]).collect(&:word).uniq
    d = Document.find(params[:id])
    word_count = Array.new
    raw_frequency = Array.new
    document_matrix = ""
    all_words.each do |w|
      word_count = []
      d.sentences.each do |s|
        words_in_s = s.words.collect(&:word)
        raw_frequency = []
        words_in_s.each do |ws|
          raw_frequency << words_in_s.count(ws)
        end
        tf = (0.5 + (0.5 * (words_in_s.count(w).to_f/raw_frequency.max))).round(2)
        logger.info "term frequency #{tf.inspect}"
        word_count << tf
      end
      wc = word_count.to_s
      wc = wc.delete("[")
      wc = wc.delete("]")
      document_matrix << "|"
      document_matrix << wc
    end
    document_matrix[0] = ""
    d.update_column(:matrix,document_matrix)
    redirect_to "/documents/matrix/#{params[:id]}"
  end

  def boolean_matrix
    all_words = Word.find_all_by_document_id(params[:id]).collect(&:word).uniq
    d = Document.find(params[:id])
    word_count = Array.new
    document_matrix = ""
    all_words.each do |w|
      word_count = []
      d.sentences.each do |s|
        words_in_s = s.words.collect(&:word)
        if words_in_s.include? w
          word_count << 1
        else
          word_count << 0
        end
      end
      wc = word_count.to_s
      wc = wc.delete("[")
      wc = wc.delete("]")
      document_matrix << "|"
      document_matrix << wc
    end
    document_matrix[0] = ""
    d.update_column(:matrix,document_matrix.to_s)
    redirect_to "/documents/matrix/#{params[:id]}"    
  end

  def log_matrix
    all_words = Word.find_all_by_document_id(params[:id]).collect(&:word).uniq
    d = Document.find(params[:id])
    word_count = Array.new
    document_matrix = ""
    all_words.each do |w|
      word_count = []
      d.sentences.each do |s|
        words_in_s = s.words.collect(&:word)
        word_count << Math.log((1 + words_in_s.count(w)),10).round(2)
      end
      wc = word_count.to_s
      wc = wc.delete("[")
      wc = wc.delete("]")
      document_matrix << "|"
      document_matrix << wc
    end
    document_matrix[0] = ""
    d.update_column(:matrix,document_matrix.to_s)
    redirect_to "/documents/matrix/#{params[:id]}"
  end

  def tfidf_matrix
    all_words = Word.find_all_by_document_id(params[:id]).collect(&:word).uniq
    d = Document.find(params[:id])
    total_sentences_in_d = d.sentences.count

    word_count = Array.new
    raw_frequency = Array.new
    document_matrix = ""
    all_words.each do |w|
      word_count = []
      d.sentences.each do |s|
        words_in_s = s.words.collect(&:word)
        raw_frequency = []
        words_in_s.each do |ws|
          raw_frequency << words_in_s.count(ws)
        end
        tf = 0.5 + (0.5 * (words_in_s.count(w).to_f/raw_frequency.max))

        # sigma_occurence_of_all_words_in_s = 0
        # all_words.each do |x|
        #   sigma_occurence_of_all_words_in_s = sigma_occurence_of_all_words_in_s + words_in_s.count(x)
        # end
        # tf = (word_occurence_in_s.to_f/sigma_occurence_of_all_words_in_s).round(3)
        # logger.info "TF of #{w.inspect}: #{tf.inspect}" 

        sentences_with_w = 0
        d.sentences.each do |y|
          words_in_y = y.words.collect(&:word)
          if words_in_y.include? w
            sentences_with_w = sentences_with_w + 1
          end
        end
        idf = (Math.log((total_sentences_in_d.to_f/sentences_with_w),10))
        tfidf = (tf * idf).round(2)
        word_count << tfidf
      end
      wc = word_count.to_s
      wc = wc.delete("[")
      wc = wc.delete("]")
      document_matrix << "|"
      document_matrix << wc
    end
    document_matrix[0] = ""
    d.update_column(:matrix,document_matrix.to_s)
    redirect_to "/documents/matrix/#{params[:id]}"
  end

  def idf_matrix
    all_words = Word.find_all_by_document_id(params[:id]).collect(&:word).uniq
    d = Document.find(params[:id])
    total_sentences_in_d = d.sentences.count

    word_count = Array.new
    document_matrix = ""
    all_words.each do |w|
      word_count = []
      d.sentences.each do |s|
        sentences_with_w = 0
        d.sentences.each do |y|
          words_in_y = y.words.collect(&:word)
          if words_in_y.include? w
            sentences_with_w = sentences_with_w + 1
          end
        end
        idf = (Math.log((total_sentences_in_d.to_f/sentences_with_w),10)).round(2)
        word_count << idf
      end
      wc = word_count.to_s
      wc = wc.delete("[")
      wc = wc.delete("]")
      document_matrix << "|"
      document_matrix << wc
    end
    document_matrix[0] = ""
    d.update_column(:matrix,document_matrix.to_s)
    redirect_to "/documents/matrix/#{params[:id]}"
  end

  def matrix
    @d = Document.find(params[:id])
    @all_words = Word.find_all_by_document_id(params[:id]).collect(&:word).uniq
    @dmatrix = @d.matrix.split("|")
  end

  def sentences
    @d = Document.find(params[:id])
  end

  def words
    @d = Document.find(params[:id])
  end

  def words_in_sentence
    @s = Sentence.find(params[:id])
  end

  def gong_liu_summary
    @d = Document.find(params[:id])
    @sentences = @d.sentences.pluck(:sentence)
    dmatrix_string = @d.matrix.split("|")
    dmatrix = Array.new
    dmatrix_string.each do |dm|
      row = dm.split(",").collect{ |s| s.to_f }
      dmatrix << row
    end
    a = DMatrix.rows dmatrix    
    u,s,@vt = a.svd
    for i in 0..@d.sentences.count - 1
      for j in 0..@d.sentences.count - 1
        if @vt[i,j] < 0
          @vt[i,j] = @vt[i,j] * (-1)  
        end
      end
    end
    @dimensions = 8
    @row_greatest = Array.new
    for i in 0..@dimensions - 1
      greatest = @vt[i,0]
      position = 0
      for j in 0..@d.sentences.count - 1
        if @vt[i,j] > greatest
          greatest = @vt[i,j]
          position = j
        end
      end
      @row_greatest << position
    end    
  end

  def steinberger_summary
    @d = Document.find(params[:id])
    @sentences = @d.sentences.pluck(:sentence)
    dmatrix_string = @d.matrix.split("|")
    dmatrix = Array.new
    dmatrix_string.each do |dm|
      row = dm.split(",").collect{ |s| s.to_f }
      dmatrix << row
    end
    a = DMatrix.rows dmatrix    
    u,s,vt = a.svd
    for i in 0..@d.sentences.count - 1
      for j in 0..@d.sentences.count - 1
        if vt[i,j] < 0
          vt[i,j] = vt[i,j] * (-1)
        end
      end
    end
    @v = vt.transpose
    @length = Array.new    
    for i in 0..@d.sentences.count - 1
      sigma_vs = 0
      for j in 0..5
        sigma_vs = sigma_vs + (@v[i,j] * s[j,j])
      end
      @length << Math.sqrt(sigma_vs).round(2)
    end
    greatest = @length[0]
    @position = 0
    for i in 0..@length.count - 1
      if @length[i] > greatest
        greatest = @length[i]
        @position = i
      end
    end
  end

  def ozsoy_cross
    @d = Document.find(params[:id])
    @sentences = @d.sentences.pluck(:sentence)
    dmatrix_string = @d.matrix.split("|")
    dmatrix = Array.new
    dmatrix_string.each do |dm|
      row = dm.split(",").collect{ |s| s.to_f }
      dmatrix << row
    end
    a = DMatrix.rows dmatrix    
    u,s,@vt = a.svd
    for i in 0..@d.sentences.count - 1
      for j in 0..@d.sentences.count - 1
        if @vt[i,j] < 0
          @vt[i,j] = @vt[i,j] * (-1)
        end
      end
    end 
    for i in 0..@d.sentences.count - 1
      sum_sentence_score = 0
      for j in 0..@d.sentences.count - 1
        sum_sentence_score = sum_sentence_score + @vt[i,j]
      end
      average_sentence_score = (sum_sentence_score / @d.sentences.count).round(3)
      for j in 0..@d.sentences.count - 1
        if @vt[i,j] < average_sentence_score
          @vt[i,j] = 0
        end
      end
    end
    @sentence_length = Array.new
    for j in 0..@d.sentences.count - 1
      sentence_score_length = 0
      for i in 0..@d.sentences.count - 1
        if @vt[i,j] > 0
          sentence_score_length = sentence_score_length + @vt[i,j]
        end
      end
      @sentence_length << sentence_score_length.round(3)
    end
    greatest = @sentence_length[0]
    @position = 0
    for i in 0..@sentence_length.count - 1
      if @sentence_length[i] > greatest
        greatest = @sentence_length[i]
        @position = i
      end
    end     
  end

  def ozsoy_topic
    @d = Document.find(params[:id])
    @sentences = @d.sentences.pluck(:sentence)
    dmatrix_string = @d.matrix.split("|")
    dmatrix = Array.new
    dmatrix_string.each do |dm|
      row = dm.split(",").collect{ |s| s.to_f }
      dmatrix << row
    end
    a = DMatrix.rows dmatrix    
    u,s,@vt = a.svd
    for i in 0..@d.sentences.count - 1
      for j in 0..@d.sentences.count - 1
        if @vt[i,j] < 0
          @vt[i,j] = @vt[i,j] * (-1)
        end
      end
    end
    for i in 0..@d.sentences.count - 1
      sum_sentence_score = 0
      for j in 0..@d.sentences.count - 1
        sum_sentence_score = sum_sentence_score + @vt[i,j]
      end
      average_sentence_score = (sum_sentence_score / @d.sentences.count).round(3)
      for j in 0..@d.sentences.count - 1
        if @vt[i,j] < average_sentence_score
          @vt[i,j] = 0
        end
      end
    end
    @sentence_length = Array.new
    for j in 0..@d.sentences.count - 1
      sentence_score_length = 0
      for i in 0..@d.sentences.count - 1
        if @vt[i,j] > 0
          sentence_score_length = sentence_score_length + @vt[i,j]
        end
      end
      @sentence_length << sentence_score_length.round(3)
    end
    for i in 0..@d.sentences.count - 1
      for j in 0..@d.sentences.count - 1
        if i == j
          sentence_score_sum = 0
          for k in 0..@d.sentences.count - 1
            sentence_score_sum = sentence_score_sum + @vt[i,k]
          end
          @concept_matrix[i,j] = sentence_score_sum
        end
      end
    end
  end

  def lsi
    @d = Document.find(params[:id])
    @words = @d.words.pluck('word').uniq
    dmatrix_string = @d.matrix.split("|")
    dmatrix = Array.new
    dmatrix_string.each do |dm|
      row = dm.split(",").collect{ |s| s.to_f }
      dmatrix << row
    end
    # logger.info "DMATRIX >> #{dmatrix.inspect}"
    a = DMatrix.rows dmatrix
    u,@s,vt = a.svd
    k = 11
    @uk = DMatrix.new(u.rows.count, k)
    for i in 0..(u.rows.count - 1)
      for j in 0..(k - 1)
         @uk[i,j] = u[i,j].round(3)
      end
    end
    @sk = DMatrix.new(k, k)
    for i in 0..(k - 1)
      for j in 0..(k - 1)
         @sk[i,j] = @s[i,j].round(3)
      end
    end
    @vkt = DMatrix.new(k, vt.columns.count)
    for i in 0..(k - 1)
      for j in 0..(vt.columns.count - 1)
         @vkt[i,j] = vt[i,j].round(3)
      end
    end
    # WORD BY SENTENCE SEMANTIC MATRIX
    @ak = @uk * @sk * @vkt
    # SENTENCE BY SENTENCE SIMILARITY MATRIX
    @sen_sen = DMatrix.new(@ak.columns.count, @ak.columns.count)
    for i in 0..(@sen_sen.rows.count - 1)
      p = @ak.column(i).elems.map { |x| x }     # to convert from DMatrix to Array
      # logger.info "p ======== #{p.inspect}"
      for j in 0..(@sen_sen.columns.count - 1)
        q = @ak.column(j).elems.map { |x| x }     # to convert from DMatrix to Array
        # logger.info "q ======== #{q.inspect}"
        @sen_sen[i,j] = cosine_similarity(p,q)
      end
    end
    # WORD BY WORD SIMILARITY MATRIX
    @word_word = DMatrix.new(@ak.rows.count, @ak.rows.count)
    for i in 0..(@word_word.rows.count - 1)
      p = @ak.row(i).elems.map { |x| x }     # to convert from DMatrix to Array
      # logger.info "p ======== #{p.inspect}"
      for j in 0..(@word_word.columns.count - 1)
        q = @ak.row(j).elems.map { |x| x }     # to convert from DMatrix to Array
        # logger.info "q ======== #{q.inspect}"
        @word_word[i,j] = cosine_similarity(p,q)
      end
    end
  end

  # Returns the cosine of the angle between the vectors associated with 2 points
  # Params:
  # a, b: list of coordinates (float or integer)
  # <tr>
  #   <td><b><%= i + 1 %></b></td>
  #     <% for j in 0..(@sen_sen.columns.count - 1) %>
  #           <td>
  #             <%= @sen_sen[i,j].round(3) %>
  #           </td>
  #     <% end %>
  # </tr>
  # Refer: https://www.bionicspirit.com/blog/2012/01/16/cosine-similarity-euclidean-distance.html

  def cosine_similarity(a, b)
    dot_product(a, b) / (magnitude(a) * magnitude(b))
  end

  def dot_product(a, b)
    products = a.zip(b).map{|a, b| a * b}
    products.inject(0) {|s,p| s + p}
  end

  def magnitude(point)
    squares = point.map{|x| x ** 2}
    Math.sqrt(squares.inject(0) {|s, c| s + c})
  end

end

# TO DISPLAY Ak, Uk, Sk, Vkt matrices
#
# <h2>LSI matrix Ak: <%= @ak.rows.count %> x <%= @ak.columns.count %></h2>
# <table border="1">
#   <tr><td></td>
#     <% for j in 1..(@ak.columns.count) %>
#       <td>Sen <%= j %></td>
#     <% end %>
#   </tr>
#   <% for i in 0..(@ak.rows.count - 1) %>
#   <tr>
#     <td><%= @words[i] %></td>
#       <% for j in 0..(@ak.columns.count - 1) %>
#         <td><%= @ak[i,j].round(3) %></td>
#       <% end %>     
#     </tr>
#   <% end %>
# </table>
# <br/>

# <h2>Term by Concept matrix Uk: <%= @uk.rows.count %> x <%= @uk.columns.count %></h2>
# <table border="1">
#   <tr><td></td>
#     <% for j in 1..(@uk.columns.count) %>
#       <td>Con <%= j %></td>
#     <% end %>
#   </tr>
#   <% for i in 0..(@uk.rows.count - 1) %>
#   <tr>
#     <td><%= @words[i] %></td>
#       <% for j in 0..(@uk.columns.count - 1) %>
#         <td><%= @uk[i,j].round(3) %></td>
#       <% end %>     
#     </tr>
#   <% end %>
# </table>
# <br/>

# <h2>Concept by Concept matrix Sk: <%= @sk.rows.count %> x <%= @sk.columns.count %></h2>
# <table border="1">
#   <tr><td></td>
#     <% for j in 1..(@sk.columns.count) %>
#       <td>Con <%= j %></td>
#     <% end %>
#   </tr>
#   <% for i in 0..(@sk.rows.count - 1) %>
#   <tr>
#     <td>Con <%= i + 1 %></td>
#       <% for j in 0..(@sk.columns.count - 1) %>
#         <td><%= @sk[i,j].round(3) %></td>
#       <% end %>     
#     </tr>
#   <% end %>
# </table>
# <br/>

# <h2>Concept by Sentence matrix Vk transpose: <%= @vkt.rows.count %> x <%= @vkt.columns.count %></h2>
# <table border="1">
#   <tr><td></td>
#     <% for j in 1..(@vkt.columns.count) %>
#       <td>Sen <%= j %></td>
#     <% end %>
#   </tr>
#   <% for i in 0..(@vkt.rows.count - 1) %>
#   <tr>
#     <td>Con <%= i + 1 %></td>
#       <% for j in 0..(@vkt.columns.count - 1) %>
#         <td><%= @vkt[i,j].round(3) %></td>
#       <% end %>     
#     </tr>
#   <% end %>
# </table>
# <br/>

#############################################################################################################
######################################## TEXT RELATIONSHIP MAP ##############################################
#############################################################################################################

# <h2>Sentence to Sentence similarity: <%= @sen_sen.rows.count %> x <%= @sen_sen.columns.count %></h2>
# <table border="1">
#   <tr><td></td>
#     <% for j in 1..(@sen_sen.columns.count) %>
#       <td><b><%= j %></b></td>
#     <% end %>
#     <td><b>Edges</b></td>
#     <td></td>
#   </tr>
#   <% for i in 0..(@sen_sen.rows.count - 1) %>
#   <% edges = 0 %>
#   <tr>
#     <td><b><%= i + 1 %></b></td>
#       <% for j in 0..(@sen_sen.columns.count - 1) %>
#           <% if @sen_sen[i,j].round(3) > 0.1 %>
#             <% edges = edges + 1 %>
#             <td style="background-color: yellow;">
#                 <%= @sen_sen[i,j].round(3) %>
#             </td>
#           <% else %>
#             <td>
#               <%= @sen_sen[i,j].round(3) %>
#             </td>
#           <% end %>
#       <% end %>
#       <% if edges > 5 %>
#         <td style="background-color: lime;"><%= edges %></td>
#         <td style="background-color: lime;"><b><%= i + 1 %></b></td>
#       <% else %>
#         <td><%= edges %></td>
#         <td><b><%= i + 1 %></b></td>
#       <% end %>         
#     </tr>
#     <% end %>
# </table>
# <br/>
# <h2>LSI matrix Ak: <%= @ak.rows.count %> x <%= @ak.columns.count %></h2>
# <table border="1">
#   <tr><td></td>
#     <% for j in 1..(@ak.columns.count) %>
#       <td>Sen <%= j %></td>
#     <% end %>
#   </tr>
#   <% for i in 0..(@ak.rows.count - 1) %>
#   <tr>
#     <td><%= @words[i] %></td>
#       <% for j in 0..(@ak.columns.count - 1) %>
#         <td><%= @ak[i,j].round(3) %></td>
#       <% end %>     
#     </tr>
#   <% end %>
# </table>
# <br/>

# <h2>Term by Concept matrix Uk: <%= @uk.rows.count %> x <%= @uk.columns.count %></h2>
# <table border="1">
#   <tr><td></td>
#     <% for j in 1..(@uk.columns.count) %>
#       <td>Con <%= j %></td>
#     <% end %>
#   </tr>
#   <% for i in 0..(@uk.rows.count - 1) %>
#   <tr>
#     <td><%= @words[i] %></td>
#       <% for j in 0..(@uk.columns.count - 1) %>
#         <td><%= @uk[i,j].round(3) %></td>
#       <% end %>     
#     </tr>
#   <% end %>
# </table>
# <br/>

# <h2>Concept by Concept matrix Sk: <%= @sk.rows.count %> x <%= @sk.columns.count %></h2>
# <table border="1">
#   <tr><td></td>
#     <% for j in 1..(@sk.columns.count) %>
#       <td>Con <%= j %></td>
#     <% end %>
#   </tr>
#   <% for i in 0..(@sk.rows.count - 1) %>
#   <tr>
#     <td>Con <%= i + 1 %></td>
#       <% for j in 0..(@sk.columns.count - 1) %>
#         <td><%= @sk[i,j].round(3) %></td>
#       <% end %>     
#     </tr>
#   <% end %>
# </table>
# <br/>

# <h2>Concept by Sentence matrix Vk transpose: <%= @vkt.rows.count %> x <%= @vkt.columns.count %></h2>
# <table border="1">
#   <tr><td></td>
#     <% for j in 1..(@vkt.columns.count) %>
#       <td>Sen <%= j %></td>
#     <% end %>
#   </tr>
#   <% for i in 0..(@vkt.rows.count - 1) %>
#   <tr>
#     <td>Con <%= i + 1 %></td>
#       <% for j in 0..(@vkt.columns.count - 1) %>
#         <td><%= @vkt[i,j].round(3) %></td>
#       <% end %>     
#     </tr>
#   <% end %>
# </table>
# <br/>
