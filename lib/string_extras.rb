# Some useful string utils. CNDLS 2008 bg.
# require "oniguruma"

module StringExtras
  String.class_eval do
    
    
    # returns 'a thing' for 'thing' and 'an object' for 'object' etc.
    def one_of
      # if I start with a vowel, return an, else return a
      # first, check exceptional words.
      special_word_a = ["user"].include?(self.downcase)
      if (special_word_a)
        det = "a"
      else
        starts_with_a_vowel = (self.downcase[0, 1].scan(/^[aeiou]/).to_s != "")
        det = (starts_with_a_vowel) ? "an" : "a"
      end
      det + " " + self #.singularize
    end
    

    def past_tense
      # bunch of special cases defined...?
        
      # bunch of general cases defined.
      suffix_ed = Proc.new {|verb| verb + 'ed'}    
      suffix_y_ied = Proc.new {|verb| verb[0..-2] + 'ied'}
      suffix_e_ed = Proc.new {|verb| verb[/ie$/] ? verb[0..-3] + 'ied' : verb + 'd'}        
      suffix_doubled = Proc.new {|verb| verb + verb[-1] + 'ed'}
      suffix_p_ed = Proc.new {|verb| verb[/ap$/] ? verb + verb[-1] + 'ed' : verb + 'ed'}       

      # one 3 chars match (ite).
      suffix_ite_itten = Proc.new {|verb| verb[0..-2] + 'ten'}  # okay, so it's a past participle. sue me; it's more consistent.
      return suffix_ite_itten.call(self) if self[/ite$/]
      
      # last char matches.
      a_ed = %w(m h f o h t x n h r k).map {|x| [x, suffix_ed]}.flatten
      a_y_ied = ['y', suffix_y_ied]
      a_e_ed = ['e', suffix_e_ed]
      a_double = ['b', suffix_doubled]
      a_p_ed = ['p', suffix_p_ed]
      a = a_ed + a_y_ied + a_e_ed + a_double + a_p_ed
      h = Hash[*a]
      h[self.last].call(self)
    end
    
    
    def for_num(n)
      nbr = (n == 0) ? "no" : n.to_s
      
      if (self.singularize == self.pluralize)
        label = (n == 1) ? "item in #{self}" : "items in #{self}"
      else
        label = (n == 1) ? self.singularize : self.pluralize
      end
      
      nbr + " " + label
    end
    
    
    def possessive(apostrophe_char="'")
      (self.match(/s$/)) ? "#{self}'" : "#{self}'s"
    end
    
    
    # returns capitalized words for a camel-case string
    def camelcase_to_title
      self.gsub(/([A-Z]+)/, ' \1').gsub(/(^|_)(.)/) { $2.upcase }
    end
    
    
    def to_url
      CGI::escape(self)
    end

    
    # cf. https://github.com/ludo/to_slug/blob/master/lib/to_slug.rb
    def to_slug
      # Perform transliteration to replace non-ascii characters with an ascii
      # character
      value = self.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '').to_s

      # Remove single quotes from input
      value.gsub!(/[']+/, '')

      # Replace any non-word character (\W) with a space
      value.gsub!(/\W+/, ' ')

      # Remove any whitespace before and after the string
      value.strip!

      # All characters should be downcased
      value.downcase!

      # Replace spaces with dashes
      value.gsub!(' ', '-')

      # Return the resulting slug
      value
    end
    
    
    def to_controller_class
      (self.pluralize.camelize + "Controller").constantize
    end
    
    
    def to_model
      (self.gsub("Controller","").classify).constantize
    end
    
    
    # used to instantiate a model based on a dom_id style
    # identifier like "person_12" -- ripped from Obie Fernandez' to_model()
    # http://www.jroller.com/obie/entry/to_model_a_complement_for
    def to_record
      self =~ /(.*?)_(\d+)$/
      class_name, id = $1, $2
      class_name.classify.constantize.find(id)
    end
    
    
    def clipping(clip_length=32)
    	clip = self[0,clip_length]
    	# don't split words
    	clip_words = clip.split(' ')
    	self_words = self.split(' ')
    	 
    	if (clip_words.last != self_words[clip_words.length-1]) && (self_words.length > 1)
    	  clip = self_words[0..clip_words.length-2].join(' ')
        clip << " ..." if self.length > (clip_length - 2)
      end  
      
    	clip
    end
    
    
    # returns an array of sentences from the string (eg; <p> content)
    # Note: period is dicey. we need to filter out honorifics (eg; 'Dr. Bronner' should not have a sentence break.),
    # as well as abbreviations (eg; 'Jan. 2' should not have a sentence break.).
    # so for periods, we look for a . followed by either:
    # - a space and then a capital letter (we're not considering sentences that start with numbers)
    # - or, that it is NOT immediately preceded by one of the honorifics (may have to add to the list)
    # Note: for XML strings, we want to make sure we are not splitting a CData. Yikes. 
    # cf: Web as Corpus Toolkit (http://www.drni.de/wac-tk/)
    # cf: TEI (http://wiki.tei-c.org)
    # *** replace with TEI XSLT? ***
    def get_sentences
      # [^\s+] -- trim any leading whitespace
      # .*? -- lazy grab of any character
      # (?<! Dr | Mrs | Mr | Prof | Sr | Ms | Fr ) -- reject if period is the end of an honorific
      # ([.!?] | $) -- grab punctuation at end of sentence, or go to the end of the string.
      # ((?=\s[A-Z]) | \s*$) -- require a space followed by a capitalized letter, or optional whitepace and the end of the string
      # OPTIONS: /xs -- extended (whitespace ok in regexp), and dotall (.'s match newline chars)
      # Note: we have to use Oniguruma gem, but the negative lookbehind (?<! ... ) is available natively in ruby 1.9
      reg = Oniguruma::ORegexp.new('[^\s+] .*? (?<! Dr | Mrs | Mr | Prof | Sr | Ms | Fr ) ([.!?] | $) ((?=\s[A-Z]) | \s*$)', :options => Oniguruma::OPTION_EXTEND)
      sentences = []
      reg.scan(self){|sentence_match| sentences << sentence_match[0]}
      sentences
    end
  
  end
end
