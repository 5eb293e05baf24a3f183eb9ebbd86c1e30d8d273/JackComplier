# To change this template, choose Tools | Templates
# and open the template in the editor.

class LexicalElements
  def initialize
    
  end
  
  def self.keyword_regex
    Regexp.new '\A(class|constructor|function|method|field|static|var|int|char|boolean|void|true|false|null|this|let|do|if|else|while|return)\Z'
  end
  
  def self.symbol_regex
    Regexp.new '\{|\}|\(|\)|\[|\]|\.|,|;|\+|-|\*|/|&|\||<|>|=|~'
  end
  
  def self.int_const_regex
    Regexp.new '\A\d{1,5}\Z'
  end
  
  def self.str_const_regex
    Regexp.new '"[^"\n]*"'
  end
  
  def self.identifier_regex
    Regexp.new '\A[a-zA-Z_]\w*'
  end
  
end
