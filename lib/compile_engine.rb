# To change this template, choose Tools | Templates
# and open the template in the editor.

class CompileEngine
  def initialize tokens
    @tokens = tokens
  end
  
  def run 
    compile_class
  end
  
  private 
    def compile_class
      "<class>\n" + 
        expect_token_value("class", @tokens.shift) + 
        expect_ClassName(@tokens.shift) +
        expect_token_value("{", @tokens.shift) +
        compile_classVarDec +
        compile_subroutine +
        expect_token_value("}", @tokens.shift) +
      "</class>"
    end
    
    def compile_classVarDec
      compile_varDec :class
    end

    def compile_subroutine
      code = ''
      while ['constructor', 'function', 'method'].include? @tokens.first[:value]     
        code = code +
        "<subroutineDec>\n" +
          expect_token_value("constructor|function|method", @tokens.shift) +
          expect_type_or_token_value("void", @tokens.shift) +
          expect_subroutineName(@tokens.shift) +
          expect_token_value('\(', @tokens.shift) +
          compile_parameterList +
          expect_token_value('\)', @tokens.shift) +
          compile_subroutineBody +
        "</subroutineDec>\n"        
      end
      code     
    end
    
    def compile_parameterList
      if ['int', 'char', 'boolean'].include? @tokens.first[:value] or @tokens.first[:value] == "identifier"
        "<parameterList>\n" +
          expect_type(@tokens.shift) +
          expect_varName(@tokens.shift) +
          expect_optional_types_varNames +
        "</parameterList>\n"
      else
        "<parameterList>\n</parameterList>\n"
      end
    end
    
    def compile_subroutineBody
      "<subroutineBody>\n" +
        expect_token_value("{", @tokens.shift) +
        compile_varDec +
        compile_statements + 
        expect_token_value("}", @tokens.shift) +       
      "</subroutineBody>\n"
    end
    
    def compile_varDec cat = nil
      classifying_txt = "var"
      tag_txt = "varDec"
      if cat == :class
        classifying_txt = "field|static"
        tag_txt = "classVarDec"
      end
      
      code = ''
      while Regexp.new(classifying_txt).match @tokens.first[:value]
        code = code +
        "<#{tag_txt}>\n" +
          expect_token_value(classifying_txt, @tokens.shift) +
          expect_type(@tokens.shift) +
          expect_varName(@tokens.shift) +
          expect_optional_varNames +
          expect_token_value(";", @tokens.shift) +
        "</#{tag_txt}>\n"        
      end
      code     
    end
    
    def compile_statements
      code = ''
      while ['let', 'if', 'while', 'do', 'return'].include? @tokens.first[:value]
        case @tokens.first[:value]
        when 'let'
          code = code + compile_let
        when 'if'
          code = code + compile_if
        when 'while'
          code = code + compile_while
        when 'do'
          code = code + compile_do
        when 'return'
          code = code + compile_return
        end    
      end
      if code.empty?
        code
      else
        "<statements>\n#{code}</statements>\n" 
      end
    end
    
    def compile_let
      "<letStatement>\n" + 
        expect_token_value("let", @tokens.shift) +
        expect_varName(@tokens.shift) + 
        expect_optional_brackets + 
        expect_token_value("=", @tokens.shift) +
        compile_expression + 
        expect_token_value(";", @tokens.shift) +
      "</letStatement>\n"
    end
    
    def compile_if
      "<ifStatement>\n" + 
        expect_token_value("if", @tokens.shift) +
        expect_token_value('\(', @tokens.shift) +
        compile_expression +
        expect_token_value('\)', @tokens.shift) +
        expect_token_value("{", @tokens.shift) +
        compile_statements + 
        expect_token_value("}", @tokens.shift) +
        expect_optional_else + 
      "</ifStatement>\n"
    end
    
    def compile_while
      "<whileStatement>\n" + 
        expect_token_value("while", @tokens.shift) +
        expect_token_value('\(', @tokens.shift) +
        compile_expression +
        expect_token_value('\)', @tokens.shift) +
        expect_token_value("{", @tokens.shift) +
        compile_statements + 
        expect_token_value("}", @tokens.shift) +
      "</whileStatement>\n"      
    end
    
    def compile_do
      "<doStatement>\n" + 
        expect_token_value("do", @tokens.shift) +
        expect_subroutineCall +
        expect_token_value(";", @tokens.shift) +
      "</doStatement>\n"
    end
    
    def compile_return
      "<returnStatement>\n" + 
        expect_token_value("return", @tokens.shift) +
        (@tokens.first[:value] == ';' ? '' : compile_expression) +
        expect_token_value(";", @tokens.shift) +       
      "</returnStatement>\n"
    end
    
    def expect_subroutineCall
      code = ''
      if @tokens[1][:value] == '.'
        code = expect_varName_or_ClassName(@tokens.shift) + expect_token_value('.', @tokens.shift) 
      end
      code = code +
        expect_subroutineName(@tokens.shift) +
        expect_token_value('\(', @tokens.shift) +
        compile_expressionList +
        expect_token_value('\)', @tokens.shift)
    end
    
    def expect_optional_else
      if @tokens.first[:value] == "else"
        expect_token_value("else", @tokens.shift) + 
        expect_token_value("{", @tokens.shift) +
        compile_statements +
        expect_token_value("}", @tokens.shift)
      else
        ''
      end
    end
    
    def expect_token_value value, token
      unless Regexp.new("\\A(#{value})\\Z").match token[:value]
        raise SyntaxError, "at line #{token[:at_line]}: expected '#{value}' but got '#{token[:value]}'"
      end
      "<#{token[:type]}>#{token[:value]}</#{token[:type]}>\n"
    end
    
    def expect_token_type type, token
      unless token[:type] == type
        raise SyntaxError, "at line #{token[:at_line]}: expected #{type} but got #{token[:type]} '#{token[:value]}'"
      end
      "<#{token[:type]}>#{token[:value]}</#{token[:type]}>\n"
    end
    
    def expect_subroutineName token
      expect_token_type "identifier", token
    end
    
    def expect_ClassName token
      expect_token_type "identifier", token
    end
    
    def expect_varName token
      expect_token_type "identifier", token
    end
    
    def expect_varName_or_ClassName token
      begin
        expect_varName token
      rescue SyntaxError => e1
        begin
          expect_ClassName token
        rescue SyntaxError => e2
          raise SyntaxError, "#{e1.message} #{e2.message}"
        end
      end     
    end
    
    def expect_subroutineName token
      expect_token_type "identifier", token
    end 
    
    def expect_optional_varNames
      code = ''
      while @tokens.first[:value] == ","
        code = code + expect_token_value(",", @tokens.shift) + expect_varName(@tokens.shift)
      end
      code
    end
    
    def expect_optional_types_varNames
      code = ''
      while @tokens.first[:value] == ","
        code = code + expect_token_value(",", @tokens.shift) + expect_type(@tokens.shift) + expect_varName(@tokens.shift)
      end
      code      
    end
    
    def expect_type token
      begin
        expect_token_value "int|char|boolean", token
      rescue SyntaxError => e1
        begin
          expect_ClassName token
        rescue SyntaxError => e2
          raise SyntaxError, "#{e1.message} #{e2.message}"
        end
      end
    end
    
    def expect_type_or_token_value(value, token)
      begin
        expect_type token
      rescue SyntaxError => e1
        begin
          expect_token_value(value, token)
        rescue SyntaxError => e2
          raise SyntaxError, "#{e1.message} #{e2.message}"
        end
      end      
    end
    
    def expect_optional_brackets
      if @tokens.first[:value] == "["
        expect_token_value("[", @tokens.shift) + 
        compile_expression +
        expect_token_value("]", @tokens.shift)
      else
        ''
      end
    end
    
    def compile_expression
      "<expression>\n" +
        compile_term + 
      "</expression>\n"
    end
    
    def compile_term
      "<term>\n" +
        expect_varName(@tokens.shift) +
      "</term>\n"
    end
    
    def compile_expressionList
      if @tokens.first[:value] == ')'
        "<expressionList>\n</expressionList>\n"
      else
        "<expressionList>\n" + 
          compile_expression +
          compile_optional_expressions +
        "</expressionList>\n"
      end
    end
    
    def compile_optional_expressions
      code = ''
      while @tokens.first[:value] == ","
        code = code + expect_token_value(",", @tokens.shift) + compile_expression
      end
      code      
    end
    
end


