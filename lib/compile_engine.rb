# To change this template, choose Tools | Templates
# and open the template in the editor.

class CompileEngine
  def initialize tokens
    @tokens = tokens
  end
  
  def run 

  end
  
  private 
    def complie_class
      "<class>" + expect_token_value("class", @tokens.shift) + expect_ClassName(@tokens.shift) + "</class>"
    end
    
    def expect_token_value(value, token)
      unless token[1] == value
        raise "expected '#{value}' but got '#{token[1]}'"
      end
      "<#{token[0]}>#{token[1]}</#{token[0]}>"
    end
    
    def expect_token_type(type, token)
      "<#{token[0]}>#{token[1]}</#{token[0]}>"
    end
    
    def expect_ClassName token
      expect_token_type("identifier", token)
    end
end


