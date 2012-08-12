# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'compile_engine'

describe CompileEngine do
  before(:each) do
    @compile_engine = CompileEngine.new tokens
  end

  describe "complie_class" do
    subject { @compile_engine.send :compile_class }
    
    context "when the tokens are from SimpleTest.jack" do
      let(:tokens) { [{:type => "keyword", :value => "class", :at_line => 1}, {:type => 'identifier', :value => "SimpleTest", :at_line => 1}, {:type => "symbol", :value => "{", :at_line =>1}, {:type => "symbol", :value => "}", :at_line => 3}] }
    
      it "should produce correct xmls" do
        #pending
        subject.should eq "<class>\n<keyword>class</keyword>\n<identifier>SimpleTest</identifier>\n<symbol>{</symbol>\n<symbol>}</symbol>\n</class>"
      end
    end
  end
  
  describe "compile_classVarDec" do
    subject { @compile_engine.send :compile_classVarDec }
    
    context "when the tokens are as the following" do
      let(:tokens) { [{:type => "keyword", :value => "field", :at_line => 1}, {:type => 'keyword', :value => "int", :at_line => 1}, {:type => "identifier", :value => "x", :at_line =>1}, {:type => "symbol", :value => ";", :at_line =>1}, {:type => "symbol", :value => ";", :at_line =>1}] }
    
      it "should produce correct xmls" do
        subject.should eq "<classVarDec>\n<keyword>field</keyword>\n<keyword>int</keyword>\n<identifier>x</identifier>\n<symbol>;</symbol>\n</classVarDec>\n"
      end
    end
    
    context "when there're more than one identifier" do
      let(:tokens) { [{:type => "keyword", :value => "field", :at_line => 1}, {:type => 'keyword', :value => "int", :at_line => 1}, {:type => "identifier", :value => "x", :at_line =>1}, {:type => "symbol", :value => ",", :at_line =>1}, {:type => "identifier", :value => "y", :at_line =>1}, {:type => "symbol", :value => ",", :at_line =>1}, {:type => "identifier", :value => "z", :at_line =>1}, {:type => "symbol", :value => ";", :at_line =>1}, {:type => "symbol", :value => ";", :at_line =>1}] }
    
      it "should produce correct xmls" do
        subject.should eq "<classVarDec>\n<keyword>field</keyword>\n<keyword>int</keyword>\n<identifier>x</identifier>\n<symbol>,</symbol>\n<identifier>y</identifier>\n<symbol>,</symbol>\n<identifier>z</identifier>\n<symbol>;</symbol>\n</classVarDec>\n"
      end
    end
    
    context "when there're two lines of classVarDec" do
      let(:tokens) { [{:type => "keyword", :value => "field", :at_line => 1}, {:type => 'keyword', :value => "int", :at_line => 1}, {:type => "identifier", :value => "x", :at_line =>1}, {:type => "symbol", :value => ",", :at_line =>1}, {:type => "identifier", :value => "y", :at_line =>1}, {:type => "symbol", :value => ",", :at_line =>1}, {:type => "identifier", :value => "z", :at_line =>1}, {:type => "symbol", :value => ";", :at_line =>1}, {:type => "keyword", :value => "field", :at_line => 1}, {:type => 'keyword', :value => "int", :at_line => 1}, {:type => "identifier", :value => "x", :at_line =>1}, {:type => "symbol", :value => ",", :at_line =>1}, {:type => "identifier", :value => "y", :at_line =>1}, {:type => "symbol", :value => ",", :at_line =>1}, {:type => "identifier", :value => "z", :at_line =>1}, {:type => "symbol", :value => ";", :at_line =>1}, {:type => "symbol", :value => ";", :at_line =>1}] }
    
      it "should produce correct xmls" do
        subject.should eq "<classVarDec>\n<keyword>field</keyword>\n<keyword>int</keyword>\n<identifier>x</identifier>\n<symbol>,</symbol>\n<identifier>y</identifier>\n<symbol>,</symbol>\n<identifier>z</identifier>\n<symbol>;</symbol>\n</classVarDec>\n" * 2
      end
    end
  end 
  
  describe "compile_subroutine" do
    subject { @compile_engine.send :compile_subroutine }
    
    context "when the method is empty" do
      let(:tokens) { [{:type => "keyword", :value => "method", :at_line => 1}, {:type => 'keyword', :value => "void", :at_line => 1}, {:type => "identifier", :value => "dispose", :at_line =>1}, {:type => "symbol", :value => "(", :at_line =>1}, {:type => "symbol", :value => ")", :at_line =>1}, {:type => "symbol", :value => "{", :at_line =>1}, {:type => "symbol", :value => "}", :at_line =>1}, {:type => "symbol", :value => "}", :at_line =>1}] }
   
      it "should produce correct xmls" do
        subject.should eq "<subroutineDec>\n<keyword>method</keyword>\n<keyword>void</keyword>\n<identifier>dispose</identifier>\n<symbol>(</symbol>\n<parameterList>\n</parameterList>\n<symbol>)</symbol>\n<subroutineBody>\n<symbol>{</symbol>\n<symbol>}</symbol>\n</subroutineBody>\n</subroutineDec>\n"
      end
    end
    
    context "when the method has a parameter list" do
      let(:tokens) { [{:type => "keyword", :value => "method", :at_line => 1}, {:type => 'keyword', :value => "void", :at_line => 1}, {:type => "identifier", :value => "dispose", :at_line =>1}, {:type => "symbol", :value => "(", :at_line =>1}, {:type => "keyword", :value => "int", :at_line => 1}, {:type => "identifier", :value => "x", :at_line =>1}, {:type => "symbol", :value => ",", :at_line => 1}, {:type => "identifier", :value => "MathClass", :at_line => 1}, {:type => "identifier", :value => "line", :at_line =>1}, {:type => "symbol", :value => ")", :at_line =>1}, {:type => "symbol", :value => "{", :at_line =>1}, {:type => "symbol", :value => "}", :at_line =>1}, {:type => "symbol", :value => "}", :at_line =>1}] }
   
      it "should produce correct xmls" do
        subject.should eq "<subroutineDec>\n<keyword>method</keyword>\n<keyword>void</keyword>\n<identifier>dispose</identifier>\n<symbol>(</symbol>\n<parameterList>\n<keyword>int</keyword>\n<identifier>x</identifier>\n<symbol>,</symbol>\n<identifier>MathClass</identifier>\n<identifier>line</identifier>\n</parameterList>\n<symbol>)</symbol>\n<subroutineBody>\n<symbol>{</symbol>\n<symbol>}</symbol>\n</subroutineBody>\n</subroutineDec>\n"
      end
    end
  end
  
  describe "compile_let" do
    subject { @compile_engine.send :compile_let }
    
    context "when the statement is 'let x = y;'" do
      let(:tokens) { [{:type => "keyword", :value => "let", :at_line => 1}, {:type => "identifier", :value => "x", :at_line => 1}, {:type => "symbol", :value => "=", :at_line => 1}, {:type => "identifier", :value => "y", :at_line => 1}, {:type => "symbol", :value => ";", :at_line => 1}] }

      it "should produce correct xmls" do
        subject.should eq "<letStatement>\n<keyword>let</keyword>\n<identifier>x</identifier>\n<symbol>=</symbol>\n<expression>\n<term>\n<identifier>y</identifier>\n</term>\n</expression>\n<symbol>;</symbol>\n</letStatement>\n"
      end        
    end
  end
  
  describe "compile_if" do
    subject { @compile_engine.send :compile_if }
    
    context "when the statement is 'if (x) { let x = y; }'" do
      let(:tokens) { [{:type => "keyword", :value => "if", :at_line => 1}, {:type => "symbol", :value => "(", :at_line => 1}, {:type => "identifier", :value => "x", :at_line => 1}, {:type => "symbol", :value => ")", :at_line => 1}, {:type => "symbol", :value => "{", :at_line => 1}, {:type => "keyword", :value => "let", :at_line => 1}, {:type => "identifier", :value => "x", :at_line => 1},  {:type => "symbol", :value => "=", :at_line => 1}, {:type => "identifier", :value => "y", :at_line => 1}, {:type => "symbol", :value => ";", :at_line => 1}, {:type => "symbol", :value => "}", :at_line => 1}, {:type => "symbol", :value => "}", :at_line => 1}] }

      it "should produce correct xmls" do
        subject.should eq "<ifStatement>\n<keyword>if</keyword>\n<symbol>(</symbol>\n<expression>\n<term>\n<identifier>x</identifier>\n</term>\n</expression>\n<symbol>)</symbol>\n<symbol>{</symbol>\n<statements>\n<letStatement>\n<keyword>let</keyword>\n<identifier>x</identifier>\n<symbol>=</symbol>\n<expression>\n<term>\n<identifier>y</identifier>\n</term>\n</expression>\n<symbol>;</symbol>\n</letStatement>\n</statements>\n<symbol>}</symbol>\n</ifStatement>\n"
      end        
    end
    
    context "when the statement is 'if (x) { let x = y; } else { let y = x;}'" do
      let(:tokens) { [{:type => "keyword", :value => "if", :at_line => 1}, {:type => "symbol", :value => "(", :at_line => 1}, {:type => "identifier", :value => "x", :at_line => 1}, {:type => "symbol", :value => ")", :at_line => 1}, {:type => "symbol", :value => "{", :at_line => 1}, {:type => "keyword", :value => "let", :at_line => 1}, {:type => "identifier", :value => "x", :at_line => 1},  {:type => "symbol", :value => "=", :at_line => 1}, {:type => "identifier", :value => "y", :at_line => 1}, {:type => "symbol", :value => ";", :at_line => 1}, {:type => "symbol", :value => "}", :at_line => 1}, 
          {:type => "keyword", :value => "else", :at_line => 1}, {:type => "symbol", :value => "{", :at_line => 1}, {:type => "keyword", :value => "let", :at_line => 1}, {:type => "identifier", :value => "y", :at_line => 1},  {:type => "symbol", :value => "=", :at_line => 1}, {:type => "identifier", :value => "x", :at_line => 1}, {:type => "symbol", :value => ";", :at_line => 1}, {:type => "symbol", :value => "}", :at_line => 1}, {:type => "symbol", :value => "}", :at_line => 1}] }

      it "should produce correct xmls" do
        subject.should eq "<ifStatement>\n<keyword>if</keyword>\n<symbol>(</symbol>\n<expression>\n<term>\n<identifier>x</identifier>\n</term>\n</expression>\n<symbol>)</symbol>\n<symbol>{</symbol>\n<statements>\n<letStatement>\n<keyword>let</keyword>\n<identifier>x</identifier>\n<symbol>=</symbol>\n<expression>\n<term>\n<identifier>y</identifier>\n</term>\n</expression>\n<symbol>;</symbol>\n</letStatement>\n</statements>\n<symbol>}</symbol>\n<keyword>else</keyword>\n<symbol>{</symbol>\n<statements>\n<letStatement>\n<keyword>let</keyword>\n<identifier>y</identifier>\n<symbol>=</symbol>\n<expression>\n<term>\n<identifier>x</identifier>\n</term>\n</expression>\n<symbol>;</symbol>\n</letStatement>\n</statements>\n<symbol>}</symbol>\n</ifStatement>\n"
      end        
    end
 
  end
  
  describe "expect_token_value" do
    subject { @compile_engine.send :expect_token_value, value, tokens.shift}
    
    context "when the value is 'class'" do
      let(:value) { 'class' }
      
      context "when the tokens is [{:type => 'keyword', :value => 'class', :at_line => 1}]" do
        let(:tokens) { [{:type => 'keyword', :value => 'class', :at_line => 1}] }
        
        it "should produce correct xmls" do
          subject.should eq "<keyword>class</keyword>\n"
        end
      end
      
      context "when the token is [{:type => 'identifier', :value => 'class2', :at_line => 2}]" do
        let(:tokens) { [{:type => 'identifier', :value => 'class2', :at_line => 2}] }
        
        it "should raise an error" do
          expect {subject}.to raise_error(SyntaxError, "at line 2: expected 'class' but got 'class2'")
        end
      end
    end
  end
  
  describe "expect_token_type" do
    subject { @compile_engine.send :expect_token_type, type, tokens.shift }
    
    context "when the type is 'identifier'" do
      let(:type) { 'identifier' }
      
      context "when the tokens is [{:type => 'identifier', :value => 'Simpleclass', :at_line => 1}]" do
        let(:tokens) { [{:type => 'identifier', :value => 'Simpleclass', :at_line => 1}] }
        
        it "should produce correct xmls" do
          subject.should eq "<identifier>Simpleclass</identifier>\n"
        end
      end
      
      context "when the token is [{:type => 'symbol', :value => ',', :at_line => 10}]" do
        let(:tokens) { [{:type => 'symbol', :value => ',', :at_line => 10}] }
        
        it "should raise an error" do
          expect {subject}.to raise_error(SyntaxError, "at line 10: expected identifier but got symbol ','")
        end
      end
    end
  end  
  
  describe "expect_type" do
    subject { @compile_engine.send :expect_type, tokens.shift }
    
    context "when the token is {:type => 'keyword', :value => 'int', :at_line => 10}" do
      let(:tokens) { [{:type => 'keyword', :value => 'int', :at_line => 10}] }
      
      it "should produce correct xml" do
        subject.should eq "<keyword>int</keyword>\n"
      end
    end
    
    context "when the token is {:type => 'identifier', :value => 'MathClass', :at_line => 10}" do
      let(:tokens) { [{:type => 'identifier', :value => 'MathClass', :at_line => 10}] }
      
      it "should produce correct xml" do
        subject.should eq "<identifier>MathClass</identifier>\n"
      end
    end
    
    context "when the token is {:type => 'symbol', :value => ';', :at_line => 10}" do
      let(:tokens) { [{:type => 'symbol', :value => ';', :at_line => 10}] }
      
      it "should raise an error" do
        expect {subject}.to raise_error(SyntaxError, "at line 10: expected 'int|char|boolean' but got ';' at line 10: expected identifier but got symbol ';'")
      end
    end
  end
  
  describe "compile_do" do
    subject { @compile_engine.send :compile_do }
     
    context "when the statement is 'do x();'" do
       let(:tokens) { [{:type => 'keyword', :value => 'do', :at_line => 10}, {:type => 'identifier', :value => 'x', :at_line => 10}, {:type => 'symbol', :value => '(', :at_line => 10}, {:type => 'symbol', :value => ')', :at_line => 10}, {:type => 'symbol', :value => ';', :at_line => 10}] }
    
       it "should produce correct xml" do
         subject.should eq "<doStatement>\n<keyword>do</keyword>\n<identifier>x</identifier>\n<symbol>(</symbol>\n<expressionList>\n</expressionList>\n<symbol>)</symbol>\n<symbol>;</symbol>\n</doStatement>\n"
       end
    end
  end
end

