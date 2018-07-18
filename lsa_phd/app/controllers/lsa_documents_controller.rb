# encoding: UTF-8
require 'linalg'
include Linalg
class LsaDocumentsController < ApplicationController

  def index
    @lsa_documents = LsaDocument.all
  end

  def show
    @lsa_document = LsaDocument.find(params[:id])
  end

  def new
    @lsa_document = LsaDocument.new
  end

  def edit
    @lsa_document = LsaDocument.find(params[:id])
  end

  def create_train_dataset
    lsa_document = LsaDocument.new(params[:document])
    lsa_document.title = "#{params[:round]}"
    lsa_document.training = "#{params[:d1]}"
    lsa_document.testing = "#{params[:d2]}"
    lsa_document.save
    # DOCUMENTS FOR TRAINING SET
    training_doc = Document.find_all_by_docno(1)
    i = 1
    training_doc.each do |d|
      c = d.content
      c = c.gsub!("."," ")
      unless c.scan("-").nil? or c.scan("-").blank? then
        c = c.gsub!("-"," ")
      end
      unless !c.scan(/\d+/).nil? or c.scan(/\d+/).blank? then
        c = c.gsub!(/\d+/," ")
      end
      unless c.scan(/\w+/).nil? or c.scan(/\w+/).blank? then
        c = c.gsub!(/\w+/," ")
      end
      c = c.gsub!(/\s+/," ")
      last = c.length - 1
      c[last] = ""
      sen = LsaSentence.new
      sen.sentence = c
      sen.lsa_document_id = lsa_document.id
      sen.document_id = d.id
      sen.label = d.label
      sen.save
      puts "CREATED TRAINING DOCUMENT #{i.inspect}/600"
      i = i + 1
    end
  end

  def create_test_dataset
    lsa_document = LsaDocument.find(params[:id])
    # DOCUMENTS FOR TESTING SET
    testing_doc = Document.find_all_by_docno(2)
    i = 1
    testing_doc.each do |d|
      c = d.content
      c = c.gsub!("."," ")
      unless c.scan("-").nil? or c.scan("-").blank? then
        c = c.gsub!("-"," ")
      end
      unless !c.scan(/\d+/).nil? or c.scan(/\d+/).blank? then
        c = c.gsub!(/\d+/," ")
      end
      unless c.scan(/\w+/).nil? or c.scan(/\w+/).blank? then
        c = c.gsub!(/\w+/," ")
      end
      c = c.gsub!(/\s+/," ")
      last = c.length - 1
      c[last] = ""
      sen = LsaTestSentence.new
      sen.sentence = c
      sen.lsa_document_id = lsa_document.id
      sen.document_id = d.id
      sen.label = d.label
      sen.save
      puts "CREATED TESTING DOCUMENT #{i.inspect}/150"
      i = i + 1
    end
  end

  def add_domain_information_to_train_set
    lsa_document = LsaDocument.find(params[:id])
    # DOCUMENTS FOR DOMAIN INFORMATION
    domain_doc = Document.find_all_by_docno(3)
    i = 1
    domain_doc.each do |d|
      c = d.content
      c = c.gsub!("."," ")
      unless c.scan("-").nil? or c.scan("-").blank? then
        c = c.gsub!("-"," ")
      end
      unless !c.scan(/\d+/).nil? or c.scan(/\d+/).blank? then
        c = c.gsub!(/\d+/," ")
      end
      unless c.scan(/\w+/).nil? or c.scan(/\w+/).blank? then
        c = c.gsub!(/\w+/," ")
      end
      c = c.gsub!(/\s+/," ")
      last = c.length - 1
      c[last] = ""
      sen = LsaSentence.new
      sen.sentence = c
      sen.lsa_document_id = lsa_document.id
      sen.document_id = d.id
      sen.label = d.label
      sen.save
      puts "ADDED DOMAIN DOCUMENT #{i.inspect}/150"
      i = i + 1
    end
  end

  def create_train_wordset
    # HINDI STOPWORD LIST
    sw = ["हूँ", "हूं", "मैं", "मैंने", "यूं", "यूंकि", "हालांकि", "बल्कि", "ताकि", "उस", "उसे", "उसी", "उसका", "उसक", "उसकी", "उसके", "उसमें", "उसम", "जिसम", "इसम", "किसम", "हर", "आप", "आपका", "आपको", "आपकी", "आपके", "अपन", "अपने", "अपना", "अपनी", "कौन", "कौनसा", "कौनसी", "यानि", "ऐसा", "ऐसे", "ऐसी", "कैसा", "कैसी", "कैसे", "वैसा", "वैसी", "वैसे", "केवल", "क्या", "थीं", "थे", "थी", "था", "कब", "इतना", "इस", "इसे", "इसमें", "इसी", "इससे", "इसकी", "इसके", "इसका", "इसक", "इसको", "जितने", "जितन", "जितना", "जितनी", "उतना", "उतन", "उतनी", "उतने", "वाल", "वाला", "वाली", "वाले", "हमारे", "हमार", "हमारा", "हमारी", "वो", "वह", "वे", "पर", "इन", "यिह", "वुह", "जिन्हें", "जिन्हों", "तिन्हें", "तिन्हों", "किन्हों", "किन्हें", "इत्यादि", "द्वारा", "इन्हें", "इन्हों", "उन्हों", "बिलकुल", "निहायत", "इन्हे", "इन्हीं", "इन्होंने", "उन्होने", "उन्हीं", "उन्हें", "कितना", "कितनी", "कितने", "दोबारा", "वग़ैरह", "वगैरह", "लेकिन", "हो", "होना", "होने", "हुआ", "हुई", "हुए", "होता", "होती", "होते", "कर", "करें", "करना", "करनी", "करने", "किया", "किए", "करता", "करती", "करते", "लिये", "लिए", "लिया", "हाँ", "हां", "नहीं", "दिया", "दिये", "दिए", "सकते", "सकता", "सकती", "सबसे", "बहुत", "वर्ग", "उन", "उनकी", "उनके", "उनको", "उनका", "जिनका", "जिनकी", "जिनके", "कहते", "रखें", "जिसे", "किसे", "किसी", "काफ़ी", "पहले", "नीचे", "यहाँ", "जैसा", "जैसी", "जैसे", "मानो", "अंदर", "भीतर", "पूरा", "सारा", "वहाँ", "वहीं", "जहाँ", "इनका", "﻿के", "हैं", "है", "गया", "में", "बनी", "एवं", "साथ", "बाद", "कुछ", "कहा", "कहे", "कहीं", "बोला", "यदि", "अभी", "सभी", "कुल", "रहा", "रहे", "रही", "जिस", "जिसक", "जिन", "तिस", "तिन", "किस", "किसक", "कोई", "तरह", "किर", "साभ", "संग", "यही", "बही", "फिर", "मगर", "का", "एक", "यह", "से", "को", "कि", "जो", "मे", "ने", "तो", "ही", "या", "तक", "ये", "दो", "जा", "ना", "एस", "पे", "सो", "भी", "और", "तब", "जब", "अत", "व", "न", "के", "की", "कई", "आदि", "तथा", "परंतु", "कम", "दूर", "उत्तर", "पूरे", "गये", "तुम", "मै", "यहां", "हुये", "कभी", "अथवा", "गयी", "प्रति", "अन्य", "जाता", "गईं", "गई", "अब", "ऊपर", "जिसमें", "बड़ा", "जाती", "जाते", "लेकर", "बड़े", "दूसरे", "जाने", "जाना", "बाहर", "स्थान", "गए", "जिससे", "बीच", "दोनों", "रहती", "इनके", "उच्च", "मध्य", "आज", "कल", "उन्होंने", "क्योंकि", "हम", "उनमें", "मुताबिक", "पहला", "पहली", "मुझ", "मेर", "मुझस", "मुझक", "जिसस", "इसस", "उसस", "किसस", "हों", "हालाँक", "सिर्फ", "जबक", "प्रत्येक", "बेहद", "अगर", "वीं", "इसलिए", "इनमें", "जिनमें", "इनम", "जिनम", "उनम", "इनक", "इनस", "उनक", "उनस", "जिनक", "जिनस", "मात्र", "वें", "क्यों", "क्य", "उन्ह", "जिन्ह", "इन्ह", "बारे", "अनुसार", "सक्षम", "में ", "भर", "वास्तव", "खिलाफ", "लगभग", "अकेले", "अलावा", "भी ", "हमेशा", "अलग", "उपलब्ध", "पर ", "जुड़े", "पूछ", "पूछते", "रूप", "ओर", "सराहना", "दिखाई", "देते", "परे", "पीछे", "विश्वास", "अच्छा", "बेहतर", "बनने", "बन", "सी", "शामिल", "युक्त", "कारण", "बनता", "निश्चित", "परिवर्तन", "स्पष्ट", "सह", "विषय", "आता", "आ", "फलस्वरूप", "विचार", "आया", "जाहिर", "वर्तमान", "दौर", "दौरान", "बावजूद", "काफी", "पूरी", "विशेष", "सब", "जगह", "पूर्व", "उदाहरण", "आगे", "मिल", "देता", "चला", "प्रकार", "निम्न", "पीछा", "बधाई", "शायद", "ही", "नमस्कार", "मदद", "अत:", "एतद्द्वारा", "खुद", "हाय", "इधर", "उम्मीद", "यानी", "करेंगे", "होगी", "ध्यान", "तत्काल", "यद्यपि", "बजाय", "भीतरी", "संकेत", "मिलता", "बस", "रखने", "रहता", "रखा", "पिछले", "हाल", "चलो", "छोटे", "अधिक", "संभावना", "पसंद", "लिमिटेड", "ए", "बी", "डी", "ई", "एफ", "जी", "एच", "एल", "एम", "एन", "ओ", "पी", "क्यू", "आर", "टी", "यू", "वी", "डब्ल्यू", "एक्स", "वाई", "जेड", "शून्य", "तीन", "चार", "पांच", "छह", "सात", "आठ", "नौ", "दस", "ग्यारह", "तीसरे", "चौथे", "पांचवें", "छठे", "सातवें", "आठवें", "नौवें", "दसवें", "ग्यारहवें", "दूसरा", "तीसरा", "चौथा", "पांचवां", "छठा", "सातवां", "आठवाँ", "नौवां", "दसवां", "ग्यारहवां", "तीसरी", "चौथी", "पांचवीं", "छठी", "सातवीं", "आठवीं", "नौवीं", "दसवीं", "ग्यारहवीं", "मुख्य", "मुझे", "अर्थात्", "मेरे", "ज्यादातर", "ज्यादा", "होगा", "मतलब", "नाम", "लग", "देख", "देखो", "पास", "आवश्यक", "जरूरत", "नया", "नए", "नयापन", "नई", "अगले", "सामान्य", "से ", "बंद", "अक्सर", "ठीक", "ओह", "पुराने", "बार", "लोगों", "दूसरों", "अन्यथा", "चाहिए", "मिलाकर", "स्वयं", "कृपया", "प्लस", "संभव", "प्रदान", "यथोचित", "भले", "सादर", "अपेक्षाकृत", "क्रमशः", "सही", "सूरत", "लगता", "लगना", "कह", "देखा", "भेजा", "गंभीर", "सच", "कई ", "करेगा", "हद", "जल्द", "माफ", "निर्दिष्ट", "उप", "समर्थन", "यकीन", "ले", "बताओ", "आदत", "धन्यवाद", "चाहते", "अच्छी", "माध्यम", "कोशिश", "संयुक्त", "दुर्भाग्य", "तहत", "बार ", "हमें", "उपयोग", "आमतौर", "मूल्य", "विभिन्न", "अर्थात", "चाहता", "स्वागत", "कहां", "जहां", "जिसका", "तैयार", "इच्छा", "बिना", "जिधर", "जबकि", "चाहे", "आश्चर्य", "जाओगे", "तुम्हारा", "पुराना", "पुरानी", "उधर", "किधर", "जाए", "जाएग", "दे", "कहना", "लेंग", "लेना", "ले", "ली", "दी", "ख़ुद", "माना", "मानने", "मानना", "मानी", "मान", "माने", "बत", "थोड़", "पा", "ग्र", "समुचित", "उचित", "उपयुक्त", "काफ़ी", "पर्याप्त", "आत", "लेग", "भेज", "सक", "तौर", "द", "आई", "चलन", "आएं", "तरफ़", "चु", "चुक", "चल", "रह", "आए", "आन", "मुताबिक़", "तभी", "पहल", "दूसर", "तीसर", "चौथ", "ज़्यादातर", "जरूर", "अवश्य", "बेवजह", "वजह", "ज़्याद", "मददगार", "अधिकांश", "फिलहाल", "अत्यधिक", "अधिकतम", "ताकी", "साढ़े", "एफ़", "ऑफ", "गुना", "पुनः", "जाऊंग", "पाऊंग", "पाय", "पाए", "पाई", "पाओ", "पान", "पाएग", "होऊंग", "आऊंग", "अंततः", "स्वतः", "ज़ाहिर", "ज़रूर", "ज़रूरत", "दरअसल", "मौजूद", "ऑफ़", "ज़्यादा", "मौजूदगी", "संभवतः", "मसलन", "हैलो", "ग़ौरतलब", "थलग", "थें", "दि", "होंग", "देंगे", "दे", "दें", "नापसंद", "एंड", "ह", "हं", "आएंग", "आएँग", "जाएंग", "जाएँग", "पाएंग", "पाएँग", "एंग", "एँग", "आएग", "एग", "होऊँग", "जाऊँग", "आऊँग", "पाऊँग", "मिलेंग", "मुख्यतः", "असल", "लिहाज़ा", "लिहाजा", "सामान्यतः", "मूलतः", "महज", "महज़", "ग़ैरमौजूदगी", "ग़ैर", "खासकर", "खास", "सलाम", "रूबरू", "रूबर", "अक्स", "रुबर", "ॐ", "नमः", "एकाध", "मत", "अनुमानतः", "प्रायः", "हालिया"]
    # WORDS FOR TRAINING SET
    root_words_in_s = Array.new
    i = 1
    lsa_document = LsaDocument.find(params[:id])
    lsa_document.lsa_sentences.each do |sentence|
      root_words_in_s = []
      s = sentence.sentence.split(" ")
      s = s - sw
      s.each do |t|
        system("echo #{t}|./hindi_stemmer.py > root_word.txt")
        file = File.new("root_word.txt", "r")
        root_word = file.gets
        unless root_word.nil? or root_word.blank?
          root_word = root_word.delete("\n")
        end
        root_words_in_s << root_word
      end
      s = root_words_in_s - sw
      s.each do |t|
        w = LsaWord.new
        w.word = t
        w.lsa_sentence_id = sentence.id
        w.lsa_document_id = lsa_document.id
        w.label = sentence.label
        w.save
      end
      puts "CREATED WORDS FOR TRAINING DOCUMENT #{i.inspect}/600"
      i = i + 1
    end
  end

  def create_test_wordset
    # HINDI STOPWORD LIST
    sw = ["हूँ", "हूं", "मैं", "मैंने", "यूं", "यूंकि", "हालांकि", "बल्कि", "ताकि", "उस", "उसे", "उसी", "उसका", "उसक", "उसकी", "उसके", "उसमें", "उसम", "जिसम", "इसम", "किसम", "हर", "आप", "आपका", "आपको", "आपकी", "आपके", "अपन", "अपने", "अपना", "अपनी", "कौन", "कौनसा", "कौनसी", "यानि", "ऐसा", "ऐसे", "ऐसी", "कैसा", "कैसी", "कैसे", "वैसा", "वैसी", "वैसे", "केवल", "क्या", "थीं", "थे", "थी", "था", "कब", "इतना", "इस", "इसे", "इसमें", "इसी", "इससे", "इसकी", "इसके", "इसका", "इसक", "इसको", "जितने", "जितन", "जितना", "जितनी", "उतना", "उतन", "उतनी", "उतने", "वाल", "वाला", "वाली", "वाले", "हमारे", "हमार", "हमारा", "हमारी", "वो", "वह", "वे", "पर", "इन", "यिह", "वुह", "जिन्हें", "जिन्हों", "तिन्हें", "तिन्हों", "किन्हों", "किन्हें", "इत्यादि", "द्वारा", "इन्हें", "इन्हों", "उन्हों", "बिलकुल", "निहायत", "इन्हे", "इन्हीं", "इन्होंने", "उन्होने", "उन्हीं", "उन्हें", "कितना", "कितनी", "कितने", "दोबारा", "वग़ैरह", "वगैरह", "लेकिन", "हो", "होना", "होने", "हुआ", "हुई", "हुए", "होता", "होती", "होते", "कर", "करें", "करना", "करनी", "करने", "किया", "किए", "करता", "करती", "करते", "लिये", "लिए", "लिया", "हाँ", "हां", "नहीं", "दिया", "दिये", "दिए", "सकते", "सकता", "सकती", "सबसे", "बहुत", "वर्ग", "उन", "उनकी", "उनके", "उनको", "उनका", "जिनका", "जिनकी", "जिनके", "कहते", "रखें", "जिसे", "किसे", "किसी", "काफ़ी", "पहले", "नीचे", "यहाँ", "जैसा", "जैसी", "जैसे", "मानो", "अंदर", "भीतर", "पूरा", "सारा", "वहाँ", "वहीं", "जहाँ", "इनका", "﻿के", "हैं", "है", "गया", "में", "बनी", "एवं", "साथ", "बाद", "कुछ", "कहा", "कहे", "कहीं", "बोला", "यदि", "अभी", "सभी", "कुल", "रहा", "रहे", "रही", "जिस", "जिसक", "जिन", "तिस", "तिन", "किस", "किसक", "कोई", "तरह", "किर", "साभ", "संग", "यही", "बही", "फिर", "मगर", "का", "एक", "यह", "से", "को", "कि", "जो", "मे", "ने", "तो", "ही", "या", "तक", "ये", "दो", "जा", "ना", "एस", "पे", "सो", "भी", "और", "तब", "जब", "अत", "व", "न", "के", "की", "कई", "आदि", "तथा", "परंतु", "कम", "दूर", "उत्तर", "पूरे", "गये", "तुम", "मै", "यहां", "हुये", "कभी", "अथवा", "गयी", "प्रति", "अन्य", "जाता", "गईं", "गई", "अब", "ऊपर", "जिसमें", "बड़ा", "जाती", "जाते", "लेकर", "बड़े", "दूसरे", "जाने", "जाना", "बाहर", "स्थान", "गए", "जिससे", "बीच", "दोनों", "रहती", "इनके", "उच्च", "मध्य", "आज", "कल", "उन्होंने", "क्योंकि", "हम", "उनमें", "मुताबिक", "पहला", "पहली", "मुझ", "मेर", "मुझस", "मुझक", "जिसस", "इसस", "उसस", "किसस", "हों", "हालाँक", "सिर्फ", "जबक", "प्रत्येक", "बेहद", "अगर", "वीं", "इसलिए", "इनमें", "जिनमें", "इनम", "जिनम", "उनम", "इनक", "इनस", "उनक", "उनस", "जिनक", "जिनस", "मात्र", "वें", "क्यों", "क्य", "उन्ह", "जिन्ह", "इन्ह", "बारे", "अनुसार", "सक्षम", "में ", "भर", "वास्तव", "खिलाफ", "लगभग", "अकेले", "अलावा", "भी ", "हमेशा", "अलग", "उपलब्ध", "पर ", "जुड़े", "पूछ", "पूछते", "रूप", "ओर", "सराहना", "दिखाई", "देते", "परे", "पीछे", "विश्वास", "अच्छा", "बेहतर", "बनने", "बन", "सी", "शामिल", "युक्त", "कारण", "बनता", "निश्चित", "परिवर्तन", "स्पष्ट", "सह", "विषय", "आता", "आ", "फलस्वरूप", "विचार", "आया", "जाहिर", "वर्तमान", "दौर", "दौरान", "बावजूद", "काफी", "पूरी", "विशेष", "सब", "जगह", "पूर्व", "उदाहरण", "आगे", "मिल", "देता", "चला", "प्रकार", "निम्न", "पीछा", "बधाई", "शायद", "ही", "नमस्कार", "मदद", "अत:", "एतद्द्वारा", "खुद", "हाय", "इधर", "उम्मीद", "यानी", "करेंगे", "होगी", "ध्यान", "तत्काल", "यद्यपि", "बजाय", "भीतरी", "संकेत", "मिलता", "बस", "रखने", "रहता", "रखा", "पिछले", "हाल", "चलो", "छोटे", "अधिक", "संभावना", "पसंद", "लिमिटेड", "ए", "बी", "डी", "ई", "एफ", "जी", "एच", "एल", "एम", "एन", "ओ", "पी", "क्यू", "आर", "टी", "यू", "वी", "डब्ल्यू", "एक्स", "वाई", "जेड", "शून्य", "तीन", "चार", "पांच", "छह", "सात", "आठ", "नौ", "दस", "ग्यारह", "तीसरे", "चौथे", "पांचवें", "छठे", "सातवें", "आठवें", "नौवें", "दसवें", "ग्यारहवें", "दूसरा", "तीसरा", "चौथा", "पांचवां", "छठा", "सातवां", "आठवाँ", "नौवां", "दसवां", "ग्यारहवां", "तीसरी", "चौथी", "पांचवीं", "छठी", "सातवीं", "आठवीं", "नौवीं", "दसवीं", "ग्यारहवीं", "मुख्य", "मुझे", "अर्थात्", "मेरे", "ज्यादातर", "ज्यादा", "होगा", "मतलब", "नाम", "लग", "देख", "देखो", "पास", "आवश्यक", "जरूरत", "नया", "नए", "नयापन", "नई", "अगले", "सामान्य", "से ", "बंद", "अक्सर", "ठीक", "ओह", "पुराने", "बार", "लोगों", "दूसरों", "अन्यथा", "चाहिए", "मिलाकर", "स्वयं", "कृपया", "प्लस", "संभव", "प्रदान", "यथोचित", "भले", "सादर", "अपेक्षाकृत", "क्रमशः", "सही", "सूरत", "लगता", "लगना", "कह", "देखा", "भेजा", "गंभीर", "सच", "कई ", "करेगा", "हद", "जल्द", "माफ", "निर्दिष्ट", "उप", "समर्थन", "यकीन", "ले", "बताओ", "आदत", "धन्यवाद", "चाहते", "अच्छी", "माध्यम", "कोशिश", "संयुक्त", "दुर्भाग्य", "तहत", "बार ", "हमें", "उपयोग", "आमतौर", "मूल्य", "विभिन्न", "अर्थात", "चाहता", "स्वागत", "कहां", "जहां", "जिसका", "तैयार", "इच्छा", "बिना", "जिधर", "जबकि", "चाहे", "आश्चर्य", "जाओगे", "तुम्हारा", "पुराना", "पुरानी", "उधर", "किधर", "जाए", "जाएग", "दे", "कहना", "लेंग", "लेना", "ले", "ली", "दी", "ख़ुद", "माना", "मानने", "मानना", "मानी", "मान", "माने", "बत", "थोड़", "पा", "ग्र", "समुचित", "उचित", "उपयुक्त", "काफ़ी", "पर्याप्त", "आत", "लेग", "भेज", "सक", "तौर", "द", "आई", "चलन", "आएं", "तरफ़", "चु", "चुक", "चल", "रह", "आए", "आन", "मुताबिक़", "तभी", "पहल", "दूसर", "तीसर", "चौथ", "ज़्यादातर", "जरूर", "अवश्य", "बेवजह", "वजह", "ज़्याद", "मददगार", "अधिकांश", "फिलहाल", "अत्यधिक", "अधिकतम", "ताकी", "साढ़े", "एफ़", "ऑफ", "गुना", "पुनः", "जाऊंग", "पाऊंग", "पाय", "पाए", "पाई", "पाओ", "पान", "पाएग", "होऊंग", "आऊंग", "अंततः", "स्वतः", "ज़ाहिर", "ज़रूर", "ज़रूरत", "दरअसल", "मौजूद", "ऑफ़", "ज़्यादा", "मौजूदगी", "संभवतः", "मसलन", "हैलो", "ग़ौरतलब", "थलग", "थें", "दि", "होंग", "देंगे", "दे", "दें", "नापसंद", "एंड", "ह", "हं", "आएंग", "आएँग", "जाएंग", "जाएँग", "पाएंग", "पाएँग", "एंग", "एँग", "आएग", "एग", "होऊँग", "जाऊँग", "आऊँग", "पाऊँग", "मिलेंग", "मुख्यतः", "असल", "लिहाज़ा", "लिहाजा", "सामान्यतः", "मूलतः", "महज", "महज़", "ग़ैरमौजूदगी", "ग़ैर", "खासकर", "खास", "सलाम", "रूबरू", "रूबर", "अक्स", "रुबर", "ॐ", "नमः", "एकाध", "मत", "अनुमानतः", "प्रायः", "हालिया"]
    # WORDS FOR TESTING SET
    root_words_in_s = Array.new
    i = 1
    lsa_document = LsaDocument.find(params[:id])
    lsa_document.lsa_test_sentences.each do |sentence|
      root_words_in_s = []
      s = sentence.sentence.split(" ")
      s = s - sw
      s.each do |t|
        system("echo #{t}|./hindi_stemmer.py > root_word.txt")
        file = File.new("root_word.txt", "r")
        root_word = file.gets
        unless root_word.nil? or root_word.blank?
          root_word = root_word.delete("\n")
        end
        root_words_in_s << root_word
      end
      s = root_words_in_s - sw
      s.each do |t|
        w = LsaTestWord.new
        w.word = t
        w.lsa_test_sentence_id = sentence.id
        w.lsa_document_id = lsa_document.id
        w.label = sentence.label
        w.save
      end
      puts "CREATED WORDS FOR TEST DOCUMENT #{i.inspect}/150"
      i = i + 1
    end
    redirect_to lsa_documents_url
  end

  def create_domain_wordset
    # HINDI STOPWORD LIST
    sw = ["हूँ", "हूं", "मैं", "मैंने", "यूं", "यूंकि", "हालांकि", "बल्कि", "ताकि", "उस", "उसे", "उसी", "उसका", "उसक", "उसकी", "उसके", "उसमें", "उसम", "जिसम", "इसम", "किसम", "हर", "आप", "आपका", "आपको", "आपकी", "आपके", "अपन", "अपने", "अपना", "अपनी", "कौन", "कौनसा", "कौनसी", "यानि", "ऐसा", "ऐसे", "ऐसी", "कैसा", "कैसी", "कैसे", "वैसा", "वैसी", "वैसे", "केवल", "क्या", "थीं", "थे", "थी", "था", "कब", "इतना", "इस", "इसे", "इसमें", "इसी", "इससे", "इसकी", "इसके", "इसका", "इसक", "इसको", "जितने", "जितन", "जितना", "जितनी", "उतना", "उतन", "उतनी", "उतने", "वाल", "वाला", "वाली", "वाले", "हमारे", "हमार", "हमारा", "हमारी", "वो", "वह", "वे", "पर", "इन", "यिह", "वुह", "जिन्हें", "जिन्हों", "तिन्हें", "तिन्हों", "किन्हों", "किन्हें", "इत्यादि", "द्वारा", "इन्हें", "इन्हों", "उन्हों", "बिलकुल", "निहायत", "इन्हे", "इन्हीं", "इन्होंने", "उन्होने", "उन्हीं", "उन्हें", "कितना", "कितनी", "कितने", "दोबारा", "वग़ैरह", "वगैरह", "लेकिन", "हो", "होना", "होने", "हुआ", "हुई", "हुए", "होता", "होती", "होते", "कर", "करें", "करना", "करनी", "करने", "किया", "किए", "करता", "करती", "करते", "लिये", "लिए", "लिया", "हाँ", "हां", "नहीं", "दिया", "दिये", "दिए", "सकते", "सकता", "सकती", "सबसे", "बहुत", "वर्ग", "उन", "उनकी", "उनके", "उनको", "उनका", "जिनका", "जिनकी", "जिनके", "कहते", "रखें", "जिसे", "किसे", "किसी", "काफ़ी", "पहले", "नीचे", "यहाँ", "जैसा", "जैसी", "जैसे", "मानो", "अंदर", "भीतर", "पूरा", "सारा", "वहाँ", "वहीं", "जहाँ", "इनका", "﻿के", "हैं", "है", "गया", "में", "बनी", "एवं", "साथ", "बाद", "कुछ", "कहा", "कहे", "कहीं", "बोला", "यदि", "अभी", "सभी", "कुल", "रहा", "रहे", "रही", "जिस", "जिसक", "जिन", "तिस", "तिन", "किस", "किसक", "कोई", "तरह", "किर", "साभ", "संग", "यही", "बही", "फिर", "मगर", "का", "एक", "यह", "से", "को", "कि", "जो", "मे", "ने", "तो", "ही", "या", "तक", "ये", "दो", "जा", "ना", "एस", "पे", "सो", "भी", "और", "तब", "जब", "अत", "व", "न", "के", "की", "कई", "आदि", "तथा", "परंतु", "कम", "दूर", "उत्तर", "पूरे", "गये", "तुम", "मै", "यहां", "हुये", "कभी", "अथवा", "गयी", "प्रति", "अन्य", "जाता", "गईं", "गई", "अब", "ऊपर", "जिसमें", "बड़ा", "जाती", "जाते", "लेकर", "बड़े", "दूसरे", "जाने", "जाना", "बाहर", "स्थान", "गए", "जिससे", "बीच", "दोनों", "रहती", "इनके", "उच्च", "मध्य", "आज", "कल", "उन्होंने", "क्योंकि", "हम", "उनमें", "मुताबिक", "पहला", "पहली", "मुझ", "मेर", "मुझस", "मुझक", "जिसस", "इसस", "उसस", "किसस", "हों", "हालाँक", "सिर्फ", "जबक", "प्रत्येक", "बेहद", "अगर", "वीं", "इसलिए", "इनमें", "जिनमें", "इनम", "जिनम", "उनम", "इनक", "इनस", "उनक", "उनस", "जिनक", "जिनस", "मात्र", "वें", "क्यों", "क्य", "उन्ह", "जिन्ह", "इन्ह", "बारे", "अनुसार", "सक्षम", "में ", "भर", "वास्तव", "खिलाफ", "लगभग", "अकेले", "अलावा", "भी ", "हमेशा", "अलग", "उपलब्ध", "पर ", "जुड़े", "पूछ", "पूछते", "रूप", "ओर", "सराहना", "दिखाई", "देते", "परे", "पीछे", "विश्वास", "अच्छा", "बेहतर", "बनने", "बन", "सी", "शामिल", "युक्त", "कारण", "बनता", "निश्चित", "परिवर्तन", "स्पष्ट", "सह", "विषय", "आता", "आ", "फलस्वरूप", "विचार", "आया", "जाहिर", "वर्तमान", "दौर", "दौरान", "बावजूद", "काफी", "पूरी", "विशेष", "सब", "जगह", "पूर्व", "उदाहरण", "आगे", "मिल", "देता", "चला", "प्रकार", "निम्न", "पीछा", "बधाई", "शायद", "ही", "नमस्कार", "मदद", "अत:", "एतद्द्वारा", "खुद", "हाय", "इधर", "उम्मीद", "यानी", "करेंगे", "होगी", "ध्यान", "तत्काल", "यद्यपि", "बजाय", "भीतरी", "संकेत", "मिलता", "बस", "रखने", "रहता", "रखा", "पिछले", "हाल", "चलो", "छोटे", "अधिक", "संभावना", "पसंद", "लिमिटेड", "ए", "बी", "डी", "ई", "एफ", "जी", "एच", "एल", "एम", "एन", "ओ", "पी", "क्यू", "आर", "टी", "यू", "वी", "डब्ल्यू", "एक्स", "वाई", "जेड", "शून्य", "तीन", "चार", "पांच", "छह", "सात", "आठ", "नौ", "दस", "ग्यारह", "तीसरे", "चौथे", "पांचवें", "छठे", "सातवें", "आठवें", "नौवें", "दसवें", "ग्यारहवें", "दूसरा", "तीसरा", "चौथा", "पांचवां", "छठा", "सातवां", "आठवाँ", "नौवां", "दसवां", "ग्यारहवां", "तीसरी", "चौथी", "पांचवीं", "छठी", "सातवीं", "आठवीं", "नौवीं", "दसवीं", "ग्यारहवीं", "मुख्य", "मुझे", "अर्थात्", "मेरे", "ज्यादातर", "ज्यादा", "होगा", "मतलब", "नाम", "लग", "देख", "देखो", "पास", "आवश्यक", "जरूरत", "नया", "नए", "नयापन", "नई", "अगले", "सामान्य", "से ", "बंद", "अक्सर", "ठीक", "ओह", "पुराने", "बार", "लोगों", "दूसरों", "अन्यथा", "चाहिए", "मिलाकर", "स्वयं", "कृपया", "प्लस", "संभव", "प्रदान", "यथोचित", "भले", "सादर", "अपेक्षाकृत", "क्रमशः", "सही", "सूरत", "लगता", "लगना", "कह", "देखा", "भेजा", "गंभीर", "सच", "कई ", "करेगा", "हद", "जल्द", "माफ", "निर्दिष्ट", "उप", "समर्थन", "यकीन", "ले", "बताओ", "आदत", "धन्यवाद", "चाहते", "अच्छी", "माध्यम", "कोशिश", "संयुक्त", "दुर्भाग्य", "तहत", "बार ", "हमें", "उपयोग", "आमतौर", "मूल्य", "विभिन्न", "अर्थात", "चाहता", "स्वागत", "कहां", "जहां", "जिसका", "तैयार", "इच्छा", "बिना", "जिधर", "जबकि", "चाहे", "आश्चर्य", "जाओगे", "तुम्हारा", "पुराना", "पुरानी", "उधर", "किधर", "जाए", "जाएग", "दे", "कहना", "लेंग", "लेना", "ले", "ली", "दी", "ख़ुद", "माना", "मानने", "मानना", "मानी", "मान", "माने", "बत", "थोड़", "पा", "ग्र", "समुचित", "उचित", "उपयुक्त", "काफ़ी", "पर्याप्त", "आत", "लेग", "भेज", "सक", "तौर", "द", "आई", "चलन", "आएं", "तरफ़", "चु", "चुक", "चल", "रह", "आए", "आन", "मुताबिक़", "तभी", "पहल", "दूसर", "तीसर", "चौथ", "ज़्यादातर", "जरूर", "अवश्य", "बेवजह", "वजह", "ज़्याद", "मददगार", "अधिकांश", "फिलहाल", "अत्यधिक", "अधिकतम", "ताकी", "साढ़े", "एफ़", "ऑफ", "गुना", "पुनः", "जाऊंग", "पाऊंग", "पाय", "पाए", "पाई", "पाओ", "पान", "पाएग", "होऊंग", "आऊंग", "अंततः", "स्वतः", "ज़ाहिर", "ज़रूर", "ज़रूरत", "दरअसल", "मौजूद", "ऑफ़", "ज़्यादा", "मौजूदगी", "संभवतः", "मसलन", "हैलो", "ग़ौरतलब", "थलग", "थें", "दि", "होंग", "देंगे", "दे", "दें", "नापसंद", "एंड", "ह", "हं", "आएंग", "आएँग", "जाएंग", "जाएँग", "पाएंग", "पाएँग", "एंग", "एँग", "आएग", "एग", "होऊँग", "जाऊँग", "आऊँग", "पाऊँग", "मिलेंग", "मुख्यतः", "असल", "लिहाज़ा", "लिहाजा", "सामान्यतः", "मूलतः", "महज", "महज़", "ग़ैरमौजूदगी", "ग़ैर", "खासकर", "खास", "सलाम", "रूबरू", "रूबर", "अक्स", "रुबर", "ॐ", "नमः", "एकाध", "मत", "अनुमानतः", "प्रायः", "हालिया"]
    # WORDS FOR TRAINING SET
    root_words_in_s = Array.new
    i = 1
    lsa_sentences = LsaSentence.find_all_by_lsa_document_id(params[:id], :conditions => 'id >= 4898 and id <= 5047')
    lsa_sentences.each do |sentence|
      root_words_in_s = []
      s = sentence.sentence.split(" ")
      s = s - sw
      s.each do |t|
        system("echo #{t}|./hindi_stemmer.py > root_word.txt")
        file = File.new("root_word.txt", "r")
        root_word = file.gets
        unless root_word.nil? or root_word.blank?
          root_word = root_word.delete("\n")
        end
        root_words_in_s << root_word
      end
      s = root_words_in_s - sw
      s.each do |t|
        w = LsaWord.new
        w.word = t
        w.lsa_sentence_id = sentence.id
        w.lsa_document_id = params[:id]
        w.label = sentence.label
        w.save
      end
      puts "CREATED WORDS FOR DOMAIN DOCUMENT #{i.inspect}/150"
      i = i + 1
    end
  end

  def tf_matrix_train
    # TF Matrix for training set all documents
    d = LsaDocument.find(params[:id])
    all_words = LsaWord.find_all_by_lsa_document_id(params[:id]).collect(&:word).uniq
    word_count = Array.new
    i = 1
    all_words.each do |w|
      word_count = []
      j = 1
      d.lsa_sentences.each do |s|
        words_in_s = s.lsa_words.collect(&:word)
        tf = words_in_s.count(w)
        word_count << tf
        puts "WORD #{i.inspect} in DOCUMENT #{j.inspect}"
        j = j + 1
      end
      wc = word_count.to_s
      wc = wc.delete("[")
      wc = wc.delete("]")
      training_unique_word = LsaTrainingUniqueWord.new
      training_unique_word.word = w 
      training_unique_word.lsa_document_id = d.id
      training_unique_word.occurrence = wc
      training_unique_word.save
      i = i + 1
    end
  end

  def inverse_category_frequency
    all_words = LsaTrainingUniqueWord.find_all_by_lsa_document_id(params[:id])
    train_sentences = LsaSentence.find_all_by_lsa_document_id(params[:id])
    total_categories = 3
    i = 1
    all_words.each do |w|
      label = []
      category_frequency = 0
      train_sentences.each do |s|
        words_in_s = s.lsa_words.collect(&:word)
        tf = words_in_s.count(w.word)
        if tf > 0 and !label.include? s.label
          label << s.label
          category_frequency = category_frequency + 1
        end
      end
      icf = (Math.log((1+(total_categories.to_f/category_frequency)),10)).round(3)
      w.update_column(:category_frequency,category_frequency)
      w.update_column(:icf,icf)
      puts "updated ICF for word #{i.inspect}"
      i = i + 1
    end
  end

  def tficf_matrix_train
    # TFICF Matrix for training set all documents
    all_words = LsaTrainingUniqueWord.find_all_by_lsa_document_id(params[:id])
    train_sentences = LsaSentence.find_all_by_lsa_document_id(params[:id])
    word_count = Array.new
    i = 1
    all_words.each do |w|
      word_count = []
      j = 1
      train_sentences.each do |s|
        words_in_s = s.lsa_words.collect(&:word)
        tf = words_in_s.count(w.word)
        icf = w.icf
        tficf = (tf * icf).round(3)
        word_count << tficf
        j = j + 1
      end
      wc = word_count.to_s
      wc = wc.delete("[")
      wc = wc.delete("]")
      w.update_column(:occurrence,wc)
      puts "CREATED TFICF MATRIX for WORD #{i.inspect}"
      i = i + 1
    end
  end

  def tficf_matrix_test
    # TFICF Matrix for testing set individual document
    all_words = LsaTrainingUniqueWord.find_all_by_lsa_document_id(params[:id])
    test_sentences = LsaTestSentence.find_all_by_lsa_document_id(params[:id])
    i = 1
    test_sentences.each do |ts|
      test_word_count = Array.new
      test_document_matrix = ""
      j = 1
      all_words.each do |wts|
        words_in_ts = ts.lsa_test_words.collect(&:word)
        tf = words_in_ts.count(wts.word)
        icf = wts.icf
        tficf = (tf * icf).round(3)
        test_word_count << tficf
        j = j + 1
      end
      twc = test_word_count.to_s
      twc = twc.delete("[")
      twc = twc.delete("]")
      test_document_matrix << twc
      ts.update_column(:matrix,test_document_matrix)
      puts "CREATED TFICF MATRIX FOR TEST DOCUMENT #{i.inspect}"
      i = i + 1
    end
  end
  
  def tf_matrix_test
    # TF Matrix for testing set all documents
    d = LsaDocument.find(params[:id])
    all_words = LsaTrainingUniqueWord.find_all_by_lsa_document_id(params[:id]).collect(&:word)
    total_unique_words = all_words.count
    puts "TOTAL WORDS #{total_unique_words.inspect}"
    # TF Matrix for testing set individual document
    test_sentences = LsaTestSentence.find_all_by_lsa_document_id(params[:id])
    i = 1
    test_sentences.each do |ts|
      test_word_count = Array.new
      test_document_matrix = ""
      j = 1
      all_words.each do |wts|
        words_in_ts = ts.lsa_test_words.collect(&:word)
        tf = words_in_ts.count(wts)
        test_word_count << tf
        puts "WORD #{j.inspect} in DOCUMENT #{i.inspect}/150"
        j = j + 1
      end
      twc = test_word_count.to_s
      twc = twc.delete("[")
      twc = twc.delete("]")
      test_document_matrix << twc
      ts.update_column(:matrix,test_document_matrix)
      i = i + 1
    end
  end

  def cslsa_tf_matrix_train
    # TF Matrix with features added for training set
    occurrence = Array.new
    lsa_document = LsaDocument.find(params[:id])
    science = LsaTrainingUniqueWord.new
    science.word = "science" 
    science.lsa_document_id = lsa_document.id
    for i in 1..750 do
      if ((i >= 1 and i <= 200) or (i >= 601 and i <= 650))
        occurrence << 1
      else 
        occurrence << 0
      end
    end
    science_label = occurrence.to_s
    science_label = science_label.delete("[")
    science_label = science_label.delete("]")
    puts "SCIENCE ---------- #{science_label.inspect}"
    science.occurrence = science_label
    science.save

    occurrence = []
    sports = LsaTrainingUniqueWord.new
    sports.word = "sports" 
    sports.lsa_document_id = lsa_document.id
    for i in 1..750 do
      if ((i >= 201 and i <=400) or (i >= 651 and i <= 700 ))
        occurrence << 1
      else 
        occurrence << 0
      end
    end
    sports_label = occurrence.to_s
    sports_label = sports_label.delete("[")
    sports_label = sports_label.delete("]")
    puts "SPORTS ---------- #{sports_label.inspect}"
    sports.occurrence = sports_label
    sports.save

    occurrence = []
    entertainment = LsaTrainingUniqueWord.new
    entertainment.word = "entertainment" 
    entertainment.lsa_document_id = lsa_document.id
    for i in 1..750 do
      if ((i >= 401 and i <= 600) or (i >= 701 and i <= 750))
        occurrence << 1
      else
        occurrence << 0
      end
    end
    entertainment_label = occurrence.to_s
    entertainment_label = entertainment_label.delete("[")
    entertainment_label = entertainment_label.delete("]")
    puts "ENTERTAINMENT ---------- #{entertainment_label.inspect}"    
    entertainment.occurrence = entertainment_label
    entertainment.save
  end

  def cslsa_tf_matrix_test
    # TF Matrix with category label set to zero for testing set
    lsa_document = LsaDocument.find(params[:id])
    test_sentences = LsaTestSentence.find_all_by_lsa_document_id(lsa_document.id)
    i = 1
    test_sentences.each do |ts|
      test_document_matrix = ts.matrix + ", 0, 0, 0"
      ts.update_column(:flsa_matrix,test_document_matrix)
      puts "Updated test document #{i.inspect}"
      i = i + 1
    end
  end

  def lsa_results
    d = LsaDocument.find(params[:id])
    matrix_rows = LsaTrainingUniqueWord.find_all_by_lsa_document_id(params[:id]).collect(&:occurrence)
    # LSA
    occ_string = ""
    matrix_rows.each do |mr|
      mr << "|"
      occ_string << mr 
    end
    puts "Rows extracted ....................."
    dmatrix_string = occ_string.split("|")
    dmatrix = Array.new
    dmatrix_string.each do |dm|
      row = dm.split(",").collect{ |s| s.to_f }    # convert string array to float array
      dmatrix << row
    end
    a = DMatrix.rows dmatrix
    puts "Matrix created ....................."
    u,s,vt = a.svd
    puts "LSA performed ....................."
    training_doc_list = Array.new
    d.lsa_sentences.each do |ls|
      training_doc_list << ls.id
    end
    puts "training_doc_list.length >>>>>>>>>>>>>>>> #{training_doc_list.length.inspect}"
    test_docs = LsaTestSentence.find_all_by_lsa_document_id(params[:id])
    total_test_docs = test_docs.count

    k = 25
    while k <= training_doc_list.length do
      puts "dimension ------------------- #{k.inspect}"
      uk = DMatrix.new(u.rows.count, k)
      for i in 0..(u.rows.count - 1)
        for j in 0..(k - 1)
          uk[i,j] = u[i,j].round(3)
        end
      end
      sk = DMatrix.new(k, k)
      for i in 0..(k - 1)
        for j in 0..(k - 1)
          sk[i,j] = s[i,j].round(3)
        end
      end
      vkt = DMatrix.new(k, vt.columns.count)
      for i in 0..(k - 1)
        for j in 0..(vt.columns.count - 1)
          vkt[i,j] = vt[i,j].round(3)
        end
      end
      sk_inverse = sk.inverse

      lsa_count = 0
      index = 1
      test_docs.each do |t|
        qmatrix = Array.new
        qmatrix_string = t.matrix.split(", ")
        qmatrix_string.each do |qm|
          row = qm.split(",").collect{ |s| s.to_f }    # convert string array to float array
          qmatrix << row
        end
        q = DMatrix.rows qmatrix
        q_transpose = q.transpose

        # Map test document into the reduced semantic space using Folding-in process
        fold_in = q_transpose * uk * sk_inverse
        
        # FOLDED-IN TEST SET SIMILARITY WITH TRAINING SET DOCUMENT-VECTOR(Vkt) MATRIX
        cosine_sim = Array.new
        cosine_sim = []
        similarity = ""
        testing_doc = fold_in.elems.map { |x| x }     # to convert from DMatrix to Array
        for j in 0..(vkt.columns.count - 1)
          training_doc = vkt.column(j).elems.map { |x| x }     # to convert from DMatrix to Array
          sim = cosine_similarity(testing_doc,training_doc).round(6)
          similarity << ","
          similarity << sim.to_s
          cosine_sim << sim
        end
        similarity[0] = ""
        highest_similarity = cosine_sim.max
        index_of_closest_doc = cosine_sim.index(highest_similarity)     #index of array with maximum value
        closest_doc = training_doc_list[index_of_closest_doc]
        label_of_closest_doc = LsaSentence.find_by_id(closest_doc).label

        if t.label == label_of_closest_doc
          lsa_count = lsa_count + 1
        end   

        flsa_result = FlsaResult.new
        flsa_result.lsa_document_id = t.lsa_document_id
        flsa_result.document_id = t.document_id
        flsa_result.label = t.label
        flsa_result.lsa_label = label_of_closest_doc
        flsa_result.lsa_max_similarity = highest_similarity
        flsa_result.dimension = k
  
        if index == total_test_docs
          flsa_result.accuracy = (lsa_count.to_f/total_test_docs).round(4) * 100
        end
        flsa_result.save
        puts "Classified test document ........... #{index.inspect}"
        index = index + 1
      end
      k = k + 25
    end    
  end

  def cslsa_results
    d = LsaDocument.find(params[:id])
    matrix_rows = LsaTrainingUniqueWord.find_all_by_lsa_document_id(params[:id]).collect(&:occurrence)
    # CLSA
    occ_string = ""
    matrix_rows.each do |mr|
      mr << "|"
      occ_string << mr 
    end
    puts "Rows extracted ....................."
    dmatrix_stringf = occ_string.split("|")
    dmatrixf = Array.new
    dmatrix_stringf.each do |dm|
      row = dm.split(",").collect{ |s| s.to_f }    # convert string array to float array
      dmatrixf << row
    end
    af = DMatrix.rows dmatrixf
    puts "CSLSA Matrix created ....................."
    uf,sf,vtf = af.svd
    puts "LSA performed ....................."
    training_doc_list = Array.new
    d.lsa_sentences.each do |ls|
      training_doc_list << ls.id
    end
    puts "training_doc_list.length >>>>>>>>>>>>>>>> #{training_doc_list.length.inspect}"
    test_docs = LsaTestSentence.find_all_by_lsa_document_id(params[:id])
    total_test_docs = test_docs.count

    k = 25
    while k <= training_doc_list.length do
      puts "dimension ------------------- #{k.inspect}"
      ukf = DMatrix.new(uf.rows.count, k)
      for i in 0..(uf.rows.count - 1)
        for j in 0..(k - 1)
          ukf[i,j] = uf[i,j].round(3)
        end
      end
      skf = DMatrix.new(k, k)
      for i in 0..(k - 1)
        for j in 0..(k - 1)
          skf[i,j] = sf[i,j].round(3)
        end
      end
      vktf = DMatrix.new(k, vtf.columns.count)
      for i in 0..(k - 1)
        for j in 0..(vtf.columns.count - 1)
          vktf[i,j] = vtf[i,j].round(3)
        end
      end
      skf_inverse = skf.inverse

      flsa_count = 0
      index = 1
      test_docs.each do |t|
        qmatrixf = Array.new
        qmatrix_stringf = t.flsa_matrix.split(", ")
        qmatrix_stringf.each do |qm|
          row = qm.split(",").collect{ |s| s.to_f }    # convert string array to float array
          qmatrixf << row
        end

        qf = DMatrix.rows qmatrixf
        qf_transpose = qf.transpose
        # Map test document into the reduced semantic space using Folding-in process
        fold_inf = qf_transpose * ukf * skf_inverse
        
        # FOLDED-IN TEST SET SIMILARITY WITH TRAINING SET DOCUMENT-VECTOR(Vkt) MATRIX
        cosine_simf = Array.new
        cosine_simf = []
        similarityf = ""
        testing_docf = fold_inf.elems.map { |x| x }     # to convert from DMatrix to Array
        for j in 0..(vktf.columns.count - 1)
          training_docf = vktf.column(j).elems.map { |x| x }     # to convert from DMatrix to Array
          simf = cosine_similarity(testing_docf,training_docf).round(6)
          similarityf << ","
          similarityf << simf.to_s
          cosine_simf << simf
        end
        similarityf[0] = ""
        highest_similarityf = cosine_simf.max
        index_of_closest_docf = cosine_simf.index(highest_similarityf)     #index of array with maximum value
        closest_docf = training_doc_list[index_of_closest_docf]
        label_of_closest_docf = LsaSentence.find_by_id(closest_docf).label

        if t.label == label_of_closest_docf
          flsa_count = flsa_count + 1
        end

        flsa_result = FlsaResult.new
        flsa_result.lsa_document_id = t.lsa_document_id
        flsa_result.document_id = t.document_id
        flsa_result.label = t.label
        flsa_result.dimension = k
        flsa_result.flsa_label = label_of_closest_docf
        flsa_result.flsa_max_similarity = highest_similarityf
        if index == total_test_docs
          flsa_result.flsa_accuracy = (flsa_count.to_f/total_test_docs).round(4) * 100
        end
        flsa_result.save
        puts "Classified test document ........... #{index.inspect}"
        index = index + 1
      end
      k = k + 25
    end
  end

  def cslsas_results
    d = LsaDocument.find(params[:id])
    matrix_rows = LsaTrainingUniqueWord.find_all_by_lsa_document_id(params[:id]).collect(&:occurrence)
    # CLSA
    occ_string = ""
    matrix_rows.each do |mr|
      mr << "|"
      occ_string << mr 
    end
    puts "Rows extracted ....................."
    dmatrix_stringf = occ_string.split("|")
    dmatrixf = Array.new
    row_limit = Array.new
    dmatrix_stringf.each do |dm|
      row = dm.split(",").collect{ |s| s.to_f }    # convert string array to float array
      row_limit = []
      for i in 0..(row.length)
        if (i >= 0 and i <= 199) or (i >= 200 and i <= 399) or (i >= 400 and i <= 599)
          row_limit << row[i]
        end
      end
      dmatrixf << row_limit
    end
    af = DMatrix.rows dmatrixf
    puts "CSLSA Matrix created ....................."
    uf,sf,vtf = af.svd
    puts "LSA performed ....................."
    training_doc_list = Array.new
    for i in 1201..1800
      if (i >= 1201 and i <= 1400) or (i >= 1401 and i <= 1600) or (i >= 1601 and i <= 1800)
        training_doc_list << i
      end
    end
    puts "training_doc_list.length >>>>>>>>>>>>>>>> #{training_doc_list.length.inspect}"
    puts "training_doc_list >>>>>>>>>>>>>>>> #{training_doc_list.inspect}"
    test_docs = LsaTestSentence.find_all_by_lsa_document_id(params[:id])
    total_test_docs = test_docs.count

    k = 25
    while k <= training_doc_list.length do
      puts "dimension ------------------- #{k.inspect}"
      ukf = DMatrix.new(uf.rows.count, k)
      for i in 0..(uf.rows.count - 1)
        for j in 0..(k - 1)
          ukf[i,j] = uf[i,j].round(3)
        end
      end
      skf = DMatrix.new(k, k)
      for i in 0..(k - 1)
        for j in 0..(k - 1)
          skf[i,j] = sf[i,j].round(3)
        end
      end
      vktf = DMatrix.new(k, vtf.columns.count)
      for i in 0..(k - 1)
        for j in 0..(vtf.columns.count - 1)
          vktf[i,j] = vtf[i,j].round(3)
        end
      end
      skf_inverse = skf.inverse

      flsa_count = 0
      index = 1
      test_docs.each do |t|
        qmatrixf = Array.new
        qmatrix_stringf = t.flsa_matrix.split(", ")
        qmatrix_stringf.each do |qm|
          row = qm.split(",").collect{ |s| s.to_f }    # convert string array to float array
          qmatrixf << row
        end

        qf = DMatrix.rows qmatrixf
        qf_transpose = qf.transpose
        # Map test document into the reduced semantic space using Folding-in process
        fold_inf = qf_transpose * ukf * skf_inverse
        
        # FOLDED-IN TEST SET SIMILARITY WITH TRAINING SET DOCUMENT-VECTOR(Vkt) MATRIX
        cosine_simf = Array.new
        cosine_simf = []
        similarityf = ""
        testing_docf = fold_inf.elems.map { |x| x }     # to convert from DMatrix to Array
        for j in 0..(vktf.columns.count - 1)
          training_docf = vktf.column(j).elems.map { |x| x }     # to convert from DMatrix to Array
          simf = cosine_similarity(testing_docf,training_docf).round(6)
          similarityf << ","
          similarityf << simf.to_s
          cosine_simf << simf
        end
        similarityf[0] = ""
        highest_similarityf = cosine_simf.max
        index_of_closest_docf = cosine_simf.index(highest_similarityf)     #index of array with maximum value
        closest_docf = training_doc_list[index_of_closest_docf]
        label_of_closest_docf = LsaSentence.find_by_id(closest_docf).label

        if t.label == label_of_closest_docf
          flsa_count = flsa_count + 1
        end

        flsa_result = FlsaResult.new
        flsa_result.lsa_document_id = t.lsa_document_id
        flsa_result.document_id = t.document_id
        flsa_result.label = t.label
        flsa_result.dimension = k
        flsa_result.flsa_label = label_of_closest_docf
        flsa_result.flsa_max_similarity = highest_similarityf
        if index == total_test_docs
          flsa_result.flsa_accuracy = (flsa_count.to_f/total_test_docs).round(4) * 100
        end
        flsa_result.save
        puts "Classified test document ........... #{index.inspect}"
        index = index + 1
      end
      k = k + 25
    end
    redirect_to "/lsa_documents/show_results/#{params[:id]}"
  end

  def dslsa_results
    d = LsaDocument.find(params[:id])
    matrix_rows = LsaTrainingUniqueWord.find_all_by_lsa_document_id(params[:id]).collect(&:occurrence)
    # DSLSA
    occ_string = ""
    matrix_rows.each do |mr|
      mr << "|"
      occ_string << mr 
    end
    puts "Rows extracted ....................."
    dmatrix_string = occ_string.split("|")
    dmatrix = Array.new
    dmatrix_string.each do |dm|
      row = dm.split(",").collect{ |s| s.to_f }    # convert string array to float array
      dmatrix << row
    end
    a = DMatrix.rows dmatrix
    puts "Matrix created ....................."
    u,s,vt = a.svd
    puts "LSA performed ....................."

    # training_doc_list = LsaSentence.all(:conditions => '(id >= 1201 and id <= 1400) or (id >= 1401 and id <= 1600) or (id >= 1601 and id <= 1800)').collect(&:id)  # 20
    # training_doc_list = LsaSentence.all(:conditions => 'id >= 3698 and id <= 4297').collect(&:id)  # 30
    # training_doc_list = LsaSentence.all(:conditions => 'id >= 3098 and id <= 3697').collect(&:id)  # 40
    # training_doc_list = LsaSentence.all(:conditions => 'id >= 2401 and id <= 3000').collect(&:id)  # 50
    # training_doc_list = LsaSentence.all(:conditions => 'id >= 1801 and id <= 2400').collect(&:id)  # 60
    # training_doc_list = LsaSentence.all(:conditions => 'id >= 1 and id <= 600').collect(&:id)  # full
    test_docs = LsaTestSentence.find_all_by_lsa_document_id(params[:id])
    total_test_docs = test_docs.count

    k = 25
    while k <= training_doc_list.length do
      puts "dimension ------------------- #{k.inspect}"
      uk = DMatrix.new(u.rows.count, k)
      for i in 0..(u.rows.count - 1)
        for j in 0..(k - 1)
          uk[i,j] = u[i,j].round(3)
        end
      end
      # puts "Uk created"
      sk = DMatrix.new(k, k)
      for i in 0..(k - 1)
        for j in 0..(k - 1)
          sk[i,j] = s[i,j].round(3)
        end
      end
      # puts "Sk created"
      vkt = DMatrix.new(k, vt.columns.count)
      for i in 0..(k - 1)
        for j in 0..(vt.columns.count - 1)
          vkt[i,j] = vt[i,j].round(3)
        end
      end
      # puts "VkT created"
      sk_inverse = sk.inverse
      # puts "Sk inverse created"
      lsa_count = 0
      index = 1
      test_docs.each do |t|
        qmatrix = Array.new
        qmatrix_string = t.matrix.split(", ")
        qmatrix_string.each do |qm|
          row = qm.split(",").collect{ |s| s.to_f }    # convert string array to float array
          qmatrix << row
        end
        q = DMatrix.rows qmatrix
        q_transpose = q.transpose

        # Map test document into the reduced semantic space using Folding-in process
        fold_in = q_transpose * uk * sk_inverse
        # puts "Folding-in test doc"
        # FOLDED-IN TEST SET SIMILARITY WITH TRAINING SET DOCUMENT-VECTOR(Vkt) MATRIX
        cosine_sim = Array.new
        cosine_sim = []
        similarity = ""
        testing_doc = fold_in.elems.map { |x| x }     # to convert from DMatrix to Array
        for j in 0..599
          training_doc = vkt.column(j).elems.map { |x| x }     # to convert from DMatrix to Array
          # puts "train doc created"
          sim = cosine_similarity(testing_doc,training_doc).round(6)
          # puts "Similarity created"
          similarity << ","
          similarity << sim.to_s
          cosine_sim << sim
        end
        similarity[0] = ""
        highest_similarity = cosine_sim.max
        index_of_closest_doc = cosine_sim.index(highest_similarity)     #index of array with maximum value
        closest_doc = training_doc_list[index_of_closest_doc]
        label_of_closest_doc = LsaSentence.find_by_id(closest_doc).label

        if t.label == label_of_closest_doc
          lsa_count = lsa_count + 1
        end

        flsa_result = FlsaResult.new
        flsa_result.lsa_document_id = t.lsa_document_id
        flsa_result.document_id = t.document_id
        flsa_result.label = t.label
        flsa_result.lsa_label = label_of_closest_doc
        flsa_result.lsa_max_similarity = highest_similarity
        flsa_result.dimension = k
        if index == total_test_docs
          flsa_result.accuracy = (lsa_count.to_f/total_test_docs).round(4) * 100
        end
        flsa_result.save
        puts "Classified test document ........... #{index.inspect}"
        index = index + 1
      end
      k = k + 25
    end
    redirect_to "/lsa_documents/show_results/#{params[:id]}"  
  end

  def cdslsa_results
    d = LsaDocument.find(params[:id])
    matrix_rows = LsaTrainingUniqueWord.find_all_by_lsa_document_id(params[:id]).collect(&:occurrence)
    # CDSLSA
    occ_string = ""
    matrix_rows.each do |mr|
      mr << "|"
      occ_string << mr 
    end
    puts "Rows extracted ....................."
    dmatrix_string = occ_string.split("|")
    dmatrix = Array.new
    dmatrix_string.each do |dm|
      row = dm.split(",").collect{ |s| s.to_f }    # convert string array to float array
      dmatrix << row
    end
    a = DMatrix.rows dmatrix
    puts "Matrix created ....................."
    u,s,vt = a.svd
    puts "LSA performed ....................."

    training_doc_list = LsaSentence.all(:conditions => 'id >= 1201 and id <= 1800').collect(&:id)  # 20
    # training_doc_list = LsaSentence.all(:conditions => 'id >= 3698 and id <= 4297').collect(&:id)  # 30
    # training_doc_list = LsaSentence.all(:conditions => 'id >= 3098 and id <= 3697').collect(&:id)  # 40
    # training_doc_list = LsaSentence.all(:conditions => 'id >= 2401 and id <= 3000').collect(&:id)  # 50
    # training_doc_list = LsaSentence.all(:conditions => 'id >= 1801 and id <= 2400').collect(&:id)  # 60
    # training_doc_list = LsaSentence.all(:conditions => 'id >= 1 and id <= 600').collect(&:id)  # full
    test_docs = LsaTestSentence.find_all_by_lsa_document_id(params[:id])
    total_test_docs = test_docs.count

    k = 25
    while k <= training_doc_list.length do
      puts "dimension ------------------- #{k.inspect}"
      uk = DMatrix.new(u.rows.count, k)
      for i in 0..(u.rows.count - 1)
        for j in 0..(k - 1)
          uk[i,j] = u[i,j].round(3)
        end
      end
      sk = DMatrix.new(k, k)
      for i in 0..(k - 1)
        for j in 0..(k - 1)
          sk[i,j] = s[i,j].round(3)
        end
      end
      vkt = DMatrix.new(k, vt.columns.count)
      for i in 0..(k - 1)
        for j in 0..(vt.columns.count - 1)
          vkt[i,j] = vt[i,j].round(3)
        end
      end
      sk_inverse = sk.inverse
      lsa_count = 0
      index = 1
      test_docs.each do |t|
        qmatrix = Array.new
        qmatrix_string = t.flsa_matrix.split(", ")
        qmatrix_string.each do |qm|
          row = qm.split(",").collect{ |s| s.to_f }    # convert string array to float array
          qmatrix << row
        end
        q = DMatrix.rows qmatrix
        q_transpose = q.transpose

        # Map test document into the reduced semantic space using Folding-in process
        fold_in = q_transpose * uk * sk_inverse
        # FOLDED-IN TEST SET SIMILARITY WITH TRAINING SET DOCUMENT-VECTOR(Vkt) MATRIX
        cosine_sim = Array.new
        cosine_sim = []
        similarity = ""
        testing_doc = fold_in.elems.map { |x| x }     # to convert from DMatrix to Array
        for j in 0..599
          training_doc = vkt.column(j).elems.map { |x| x }     # to convert from DMatrix to Array
          sim = cosine_similarity(testing_doc,training_doc).round(6)
          similarity << ","
          similarity << sim.to_s
          cosine_sim << sim
        end
        similarity[0] = ""
        highest_similarity = cosine_sim.max
        index_of_closest_doc = cosine_sim.index(highest_similarity)     #index of array with maximum value
        closest_doc = training_doc_list[index_of_closest_doc]
        label_of_closest_doc = LsaSentence.find_by_id(closest_doc).label

        if t.label == label_of_closest_doc
          lsa_count = lsa_count + 1
        end

        flsa_result = FlsaResult.new
        flsa_result.lsa_document_id = t.lsa_document_id
        flsa_result.document_id = t.document_id
        flsa_result.label = t.label
        flsa_result.flsa_label = label_of_closest_doc
        flsa_result.flsa_max_similarity = highest_similarity
        flsa_result.dimension = k
        if index == total_test_docs
          flsa_result.flsa_accuracy = (lsa_count.to_f/total_test_docs).round(4) * 100
        end
        flsa_result.save
        puts "Classified test document ........... #{index.inspect}"
        index = index + 1
      end
      k = k + 25
    end
    redirect_to "/lsa_documents/show_results/#{params[:id]}"  
  end

  def show_results
    @flsa_results = FlsaResult.find_all_by_lsa_document_id(params[:id], :conditions => 'flsa_accuracy is not null')
  end

  def create_summary_train_set
    lsa_document = LsaDocument.new(params[:document])
    lsa_document.title = "#{params[:round]}"    
    lsa_document.training = "#{params[:d1]}"
    lsa_document.testing = "#{params[:d2]}"
    lsa_document.save    
    summary = ""
    # DOCUMENTS FOR TRAINING SET
    it = 1
    training_doc = Document.find_all_by_docno(lsa_document.training)
    training_doc.each do |d|
      ################################## gong-liu summary ###############################
      sentences = d.sentences.pluck(:sentence)
      dmatrix_string = d.matrix.split("|")
      dmatrix = Array.new
      dmatrix_string.each do |dm|
        row = dm.split(",").collect{ |s| s.to_f }
        dmatrix << row
      end
      a = DMatrix.rows dmatrix    
      u,s,vt = a.svd
      for i in 0..d.sentences.count - 1
        for j in 0..d.sentences.count - 1
          if vt[i,j] < 0
            vt[i,j] = vt[i,j] * (-1)  
          end
        end
      end
      dimensions = (sentences.count * 0.30).ceil
      row_greatest = Array.new
      for i in 0..dimensions - 1
        greatest = vt[i,0]
        position = 0
        for j in 0..d.sentences.count - 1
          if vt[i,j] > greatest
            greatest = vt[i,j]
            position = j
          end
        end
        row_greatest << position
      end            
      for k in 0..sentences.count - 1
        if row_greatest.include? k
          summary = summary + sentences[k] + "."
        end
      end
      #################################### gong-liu summary end ###########################
      c = summary
      c = c.gsub!("."," ")
      unless c.scan("-").nil? or c.scan("-").blank? then
        c = c.gsub!("-"," ")
      end
      unless !c.scan(/\d+/).nil? or c.scan(/\d+/).blank? then
        c = c.gsub!(/\d+/," ")
      end
      unless c.scan(/\w+/).nil? or c.scan(/\w+/).blank? then
        c = c.gsub!(/\w+/," ")
      end
      c = c.gsub!(/\s+/," ")
      last = c.length - 1
      c[last] = ""
      sen = LsaSentence.new
      sen.sentence = summary
      sen.lsa_document_id = lsa_document.id
      sen.document_id = d.id
      sen.label = d.label
      sen.save
      summary = ""
      puts "created summary for train document #{it.inspect}/600"
      it = it + 1
    end     
  end

  def create_summary_test_set
    lsa_document = LsaDocument.find(params[:id])
    summary = ""
    # DOCUMENTS FOR TESTING SET
    it = 1
    testing_doc = Document.find_all_by_docno(lsa_document.testing)
    testing_doc.each do |d|
      ################################## gong-liu summary ###############################
      sentences = d.sentences.pluck(:sentence)
      dmatrix_string = d.matrix.split("|")
      dmatrix = Array.new
      dmatrix_string.each do |dm|
        row = dm.split(",").collect{ |s| s.to_f }
        dmatrix << row
      end
      a = DMatrix.rows dmatrix    
      u,s,vt = a.svd
      for i in 0..d.sentences.count - 1
        for j in 0..d.sentences.count - 1
          if vt[i,j] < 0
            vt[i,j] = vt[i,j] * (-1)  
          end
        end
      end
      dimensions = (sentences.count * 0.30).ceil
      row_greatest = Array.new
      for i in 0..dimensions - 1
        greatest = vt[i,0]
        position = 0
        for j in 0..d.sentences.count - 1
          if vt[i,j] > greatest
            greatest = vt[i,j]
            position = j
          end
        end
        row_greatest << position
      end            
      for k in 0..sentences.count - 1
        if row_greatest.include? k
          summary = summary + sentences[k] + "."
        end
      end
      ################################### gong-liu summary end ###########################
      c = summary
      c = c.gsub!("."," ")
      unless c.scan("-").nil? or c.scan("-").blank? then
        c = c.gsub!("-"," ")
      end
      unless !c.scan(/\d+/).nil? or c.scan(/\d+/).blank? then
        c = c.gsub!(/\d+/," ")
      end
      unless c.scan(/\w+/).nil? or c.scan(/\w+/).blank? then
        c = c.gsub!(/\w+/," ")
      end
      c = c.gsub!(/\s+/," ")
      last = c.length - 1
      c[last] = ""
      sen = LsaTestSentence.new
      sen.sentence = summary
      sen.lsa_document_id = lsa_document.id
      sen.document_id = d.id
      sen.label = d.label
      sen.save
      summary = ""
      puts "created summary for test document #{it.inspect}/150"
      it = it + 1
    end     
  end

  def add_domain_information_summary_to_train_set
    lsa_document = LsaDocument.find(params[:id])
    summary = ""
    # DOCUMENTS FOR DOMAIN INFORMATION
    domain_doc = Document.find_all_by_docno(3)
    it = 1
    domain_doc.each do |d|
      ################################## gong-liu summary ###############################
      sentences = d.sentences.pluck(:sentence)
      dmatrix_string = d.matrix.split("|")
      dmatrix = Array.new
      dmatrix_string.each do |dm|
        row = dm.split(",").collect{ |s| s.to_f }
        dmatrix << row
      end
      a = DMatrix.rows dmatrix    
      u,s,vt = a.svd
      for i in 0..d.sentences.count - 1
        for j in 0..d.sentences.count - 1
          if vt[i,j] < 0
            vt[i,j] = vt[i,j] * (-1)  
          end
        end
      end
      dimensions = (sentences.count * 0.60).ceil
      row_greatest = Array.new
      for i in 0..dimensions - 1
        greatest = vt[i,0]
        position = 0
        for j in 0..d.sentences.count - 1
          if vt[i,j] > greatest
            greatest = vt[i,j]
            position = j
          end
        end
        row_greatest << position
      end            
      for k in 0..sentences.count - 1
        if row_greatest.include? k
          summary = summary + sentences[k] + "."
        end
      end
      ################################### gong-liu summary end ###########################
      c = summary
      c = c.gsub!("."," ")
      unless c.scan("-").nil? or c.scan("-").blank? then
        c = c.gsub!("-"," ")
      end
      unless !c.scan(/\d+/).nil? or c.scan(/\d+/).blank? then
        c = c.gsub!(/\d+/," ")
      end
      unless c.scan(/\w+/).nil? or c.scan(/\w+/).blank? then
        c = c.gsub!(/\w+/," ")
      end
      c = c.gsub!(/\s+/," ")
      last = c.length - 1
      c[last] = ""
      sen = LsaSentence.new
      sen.sentence = summary
      sen.lsa_document_id = lsa_document.id
      sen.document_id = d.id
      sen.label = d.label
      sen.save
      summary = ""
      puts "ADDED DOMAIN SUMMARY DOCUMENT #{it.inspect}/150"
      it = it + 1
    end 
  end

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

  def train_sentences
    @d = LsaDocument.find(params[:id])
  end

  def words
    @d = LsaDocument.find(params[:id])
  end

  def words_in_sentence
    @s = LsaSentence.find(params[:id])
  end

  def test_sentences
    @d = LsaDocument.find(params[:id])
  end

  def test_words
    @d = LsaDocument.find(params[:id])
  end

  def words_in_test_sentence
    @s = LsaTestSentence.find(params[:id])
  end

  def update
    @lsa_document = LsaDocument.find(params[:id])
    @lsa_document.update_attributes(params[:lsa_document])
    redirect_to @lsa_document, notice: 'Lsa document was successfully updated.'
  end

  def destroy
    @lsa_document = LsaDocument.find(params[:id])
    @lsa_document.destroy
    redirect_to lsa_documents_url
  end

  def documents_classified_correctly
    # d = FlsaResult.all(:conditions => 'id >= 1 and id <= 150')
    # d = FlsaResult.all(:conditions => 'id >= 151 and id <= 300')
    # d = FlsaResult.all(:conditions => 'id >= 301 and id <= 450')
    # d = FlsaResult.all(:conditions => 'id >= 451 and id <= 600')
    # d = FlsaResult.all(:conditions => 'id >= 601 and id <= 750')
    # d = FlsaResult.all(:conditions => 'id >= 751 and id <= 900')
    # d = FlsaResult.all(:conditions => 'id >= 901 and id <= 1050')
    # d = FlsaResult.all(:conditions => 'id >= 1051 and id <= 1200')
    # d = FlsaResult.all(:conditions => 'id >= 1201 and id <= 1350')
    # d = FlsaResult.all(:conditions => 'id >= 1351 and id <= 1500')
    # d = FlsaResult.all(:conditions => 'id >= 1501 and id <= 1650')
    # d = FlsaResult.all(:conditions => 'id >= 1651 and id <= 1800')
    # d = FlsaResult.all(:conditions => 'id >= 1801 and id <= 1950')
    # d = FlsaResult.all(:conditions => 'id >= 1951 and id <= 2100')
    # d = FlsaResult.all(:conditions => 'id >= 2101 and id <= 2250')
    # d = FlsaResult.all(:conditions => 'id >= 2251 and id <= 2400')
    # d = FlsaResult.all(:conditions => 'id >= 2401 and id <= 2550')
    # d = FlsaResult.all(:conditions => 'id >= 2551 and id <= 2700')
    # d = FlsaResult.all(:conditions => 'id >= 2701 and id <= 2850')
    # d = FlsaResult.all(:conditions => 'id >= 2851 and id <= 3000')
    # d = FlsaResult.all(:conditions => 'id >= 3001 and id <= 3150')
    # d = FlsaResult.all(:conditions => 'id >= 3151 and id <= 3300')
    # d = FlsaResult.all(:conditions => 'id >= 3301 and id <= 3450')
    # d = FlsaResult.all(:conditions => 'id >= 3451 and id <= 3600')

    # d = FlsaResult.all(:conditions => 'id >= 18001 and id <= 18150')
    # d = FlsaResult.all(:conditions => 'id >= 18151 and id <= 18300')
    # d = FlsaResult.all(:conditions => 'id >= 18301 and id <= 18450')
    # d = FlsaResult.all(:conditions => 'id >= 18451 and id <= 18600')
    # d = FlsaResult.all(:conditions => 'id >= 18601 and id <= 18750')
    # d = FlsaResult.all(:conditions => 'id >= 18751 and id <= 18900')
    # d = FlsaResult.all(:conditions => 'id >= 18901 and id <= 19050')
    # d = FlsaResult.all(:conditions => 'id >= 19051 and id <= 19200')
    # d = FlsaResult.all(:conditions => 'id >= 19201 and id <= 19350')
    # d = FlsaResult.all(:conditions => 'id >= 19351 and id <= 19500')
    # d = FlsaResult.all(:conditions => 'id >= 19501 and id <= 19650')
    # d = FlsaResult.all(:conditions => 'id >= 19651 and id <= 19800')
    # d = FlsaResult.all(:conditions => 'id >= 19801 and id <= 19950')
    # d = FlsaResult.all(:conditions => 'id >= 19951 and id <= 20100')
    # d = FlsaResult.all(:conditions => 'id >= 20101 and id <= 20250')
    # d = FlsaResult.all(:conditions => 'id >= 20251 and id <= 20400')
    # d = FlsaResult.all(:conditions => 'id >= 20401 and id <= 20550')
    # d = FlsaResult.all(:conditions => 'id >= 20551 and id <= 20700')
    # d = FlsaResult.all(:conditions => 'id >= 20701 and id <= 20850')
    # d = FlsaResult.all(:conditions => 'id >= 20851 and id <= 21000')
    # d = FlsaResult.all(:conditions => 'id >= 21001 and id <= 21150')
    # d = FlsaResult.all(:conditions => 'id >= 21151 and id <= 21300')
    # d = FlsaResult.all(:conditions => 'id >= 21301 and id <= 21450')
    # d = FlsaResult.all(:conditions => 'id >= 21451 and id <= 21600')
    @science = 0
    @sports = 0
    @entertainment = 0
    d.each do |i|
      if (i.flsa_label == "science") and (i.label == "science")
        @science = @science + 1
      elsif (i.flsa_label == "sports") and (i.label == "sports")
        @sports = @sports + 1
      elsif (i.flsa_label == "entertainment") and (i.label == "entertainment")
        @entertainment = @entertainment + 1
      end
    end
  end
end
