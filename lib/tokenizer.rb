# To change this template, choose Tools | Templates
# and open the template in the editor.
require "lexical_elements"

class Tokenizer
  def initialize
 
  end
  
  def run input_filename
    tokens = Array.new
    File.open(input_filename).each_line.with_index do |line, line_num|  
      line = remove_comment line
      
      line.scan(Regexp.union(LexicalElements.symbol_regex, LexicalElements.str_const_regex, Regexp.new('\w+'))) do |terminal_value|
        if LexicalElements.int_const_regex.match terminal_value
          terminal = {:type => "int_const", :value => terminal_value, :at_line => line_num + 1}
        elsif LexicalElements.str_const_regex.match terminal_value
          terminal = {:type => "str_const", :value => terminal_value, :at_line => line_num + 1}
        elsif LexicalElements.symbol_regex.match terminal_value
          terminal = {:type => "symbol", :value => terminal_value, :at_line => line_num + 1}
        elsif LexicalElements.identifier_regex.match terminal_value
          terminal = {:type => "identifier", :value => terminal_value, :at_line => line_num + 1}
          if LexicalElements.keyword_regex.match terminal_value
            terminal = {:type => "keyword", :value => terminal_value, :at_line => line_num + 1}
          end 
        else
          raise SyntaxError, "at line #{line_num + 1}: invalid string '#{terminal_value}'"
        end
        
        tokens << terminal
      end
    end
    tokens
  end
  
  private
    def remove_comment str
      str.split(/\/\/|\/\*|\A\s*\*/).first
    end
end
