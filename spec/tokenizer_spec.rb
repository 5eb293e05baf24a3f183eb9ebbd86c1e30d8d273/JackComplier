# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'tokenizer'

describe Tokenizer do
  before(:each) do
    @tokenizer = Tokenizer.new
  end

  describe "run" do
    subject { @tokenizer.run input_filename }
    
    context "when the input file 'SimpleTest.jack'" do 
      let(:input_filename) { "#{Dir.getwd}/spec/filemocks/single_jack_file/SimpleTest.jack" }
      
      it "should produce correct tokens" do
        subject.should eq [{:type => "keyword", :value => "class", :at_line => 1}, {:type => 'identifier', :value => "SimpleTest", :at_line => 1}, {:type => "symbol", :value => "{", :at_line =>1}, {:type => "symbol", :value => "}", :at_line => 3}]
      end
    end
    
    context "when the input file 'SimpleTestWithVarDec.jack'" do  
      let(:input_filename) { "#{Dir.getwd}/spec/filemocks/single_jack_file/SimpleTestWithVarDec.jack" }
      
      it "should produce correct tokens" do
        subject.should eq [{:type => "keyword", :value => "class", :at_line => 1}, {:type => 'identifier', :value => "SimpleTestWithVarDec", :at_line => 1}, {:type => "symbol", :value => "{", :at_line => 1}, {:type => "keyword", :value => "field", :at_line => 2}, {:type => "keyword", :value => "int", :at_line => 2}, {:type => 'identifier', :value => "x", :at_line => 2}, {:type => "symbol", :value => ",", :at_line => 2}, {:type => 'identifier', :value => "y", :at_line => 2}, {:type => "symbol", :value => ";", :at_line => 2}, {:type => "symbol", :value => "}", :at_line => 3}]
      end
    end
    
    context "when the input file 'SimpleTestWithVarDecMethondDec.jack'" do
      let(:input_filename) { "#{Dir.getwd}/spec/filemocks/single_jack_file/SimpleTestWithVarDecMethondDec.jack" }
      
      it "should produce correct tokens" do
        subject.should eq [{:type => "keyword", :value => "class", :at_line => 1}, {:type => 'identifier', :value => "SimpleTestWithVarDecMethondDec", :at_line => 1}, {:type => "symbol", :value => "{", :at_line => 1}, {:type => "keyword", :value => "field", :at_line => 2}, {:type => "keyword", :value => "int", :at_line => 2}, {:type => 'identifier', :value => "x", :at_line => 2}, {:type => "symbol", :value => "=", :at_line => 2}, {:type => "int_const", :value => "6", :at_line => 2}, {:type => "symbol", :value => ",", :at_line => 2}, {:type => 'identifier', :value => "y", :at_line => 2}, {:type => "symbol", :value => ";", :at_line => 2}, {:type => "keyword", :value => "method", :at_line => 4},
          {:type => "keyword", :value => "void", :at_line => 4}, {:type => "identifier", :value => "dispose", :at_line => 4}, {:type => "symbol", :value => "(", :at_line => 4}, {:type => "symbol", :value => ")", :at_line => 4}, {:type => "symbol", :value => "{", :at_line => 4}, {:type => "keyword", :value => "do", :at_line => 5}, {:type => "identifier", :value => "Memory", :at_line => 5}, 
          {:type => "symbol", :value => ".", :at_line => 5}, {:type => "identifier", :value => "deAlloc", :at_line => 5}, {:type => "symbol", :value => "(", :at_line => 5}, {:type => "identifier", :value => "x", :at_line => 5}, {:type => "symbol", :value => ")", :at_line => 5}, {:type => "symbol", :value => ";", :at_line => 5}, {:type => "keyword", :value => "return", :at_line => 6}, {:type => "symbol", :value => ";", :at_line => 6}, {:type => "symbol", :value => "}", :at_line => 7}, {:type => "symbol", :value => "}", :at_line => 8}]
      end
    end
    
    context "when the input file 'SimpleTestWithVarDecMethondDecWithComments.jack'" do
      let(:input_filename) { "#{Dir.getwd}/spec/filemocks/single_jack_file/SimpleTestWithVarDecMethondDecWithComments.jack" }
      
      it "should produce correct tokens" do
        subject.should eq [{:type => "keyword", :value => "class", :at_line => 9}, {:type => 'identifier', :value => "SimpleTestWithVarDecMethondDecWithComments", :at_line => 9}, {:type => "symbol", :value => "{", :at_line => 9}, {:type => "keyword", :value => "field", :at_line => 10}, {:type => "keyword", :value => "int", :at_line => 10}, {:type => 'identifier', :value => "x", :at_line => 10}, {:type => "symbol", :value => "=", :at_line => 10}, {:type => "str_const", :value => '"long value"', :at_line => 10}, {:type => "symbol", :value => ",", :at_line => 10}, {:type => 'identifier', :value => "y", :at_line => 10}, {:type => "symbol", :value => ";", :at_line => 10}, {:type => "keyword", :value => "method", :at_line => 12},
          {:type => "keyword", :value => "void", :at_line => 12}, {:type => "identifier", :value => "dispose", :at_line => 12}, {:type => "symbol", :value => "(", :at_line => 12}, {:type => "symbol", :value => ")", :at_line => 12}, {:type => "symbol", :value => "{", :at_line => 12}, {:type => "keyword", :value => "do", :at_line => 13}, {:type => "identifier", :value => "Memory", :at_line => 13}, 
          {:type => "symbol", :value => ".", :at_line => 13}, {:type => "identifier", :value => "deAlloc", :at_line => 13}, {:type => "symbol", :value => "(", :at_line => 13}, {:type => "identifier", :value => "x", :at_line => 13}, {:type => "symbol", :value => ")", :at_line => 13}, {:type => "symbol", :value => ";", :at_line => 13}, {:type => "keyword", :value => "return", :at_line => 14}, {:type => "symbol", :value => ";", :at_line => 14}, {:type => "symbol", :value => "}", :at_line => 15}, {:type => "symbol", :value => "}", :at_line => 16}]
      end
    end
    
    context "when the input file 'source.jack'" do
      let(:input_filename) { "#{Dir.getwd}/spec/filemocks/single_jack_file/source.jack" }
      
      it "should produce nothing" do
        subject.should eq []
      end
    end
    
    context "when the input file 'SimpleTestWithInvalidIdentifier.jack'" do  
      let(:input_filename) { "#{Dir.getwd}/spec/filemocks/single_jack_file/SimpleTestWithInvalidIdentifier.jack" }
      
      it "should raise an error" do
        expect {subject}.to raise_error(SyntaxError, "at line 2: invalid string '2x'")
      end
    end
    
  end
  
  describe "remove_comment" do
    subject { @tokenizer.send(:remove_comment, str) }
    
    context "when the str is '//This is a comment'" do
      let(:str) { '//This is a comment' }
      
      it "should return an empty string" do
        subject.should eq ''
      end
    end
    
    context "when the str is 'x = 3; //This is a comment'" do
      let(:str) { 'x = 3; //This is a comment' }
      
      it "should return 'x = 3; '" do
        subject.should eq 'x = 3; '
      end
    end
   
    context "when the str is '/* comment until closing */'" do
      let(:str) { '  /* comment until closing */   ' }
      
      it "should return '  '" do
        subject.should eq '  '
      end
    end
    
    context "when the str is 'void method()/** API comment start */'" do
      let(:str) { 'void method()/** API comment start */' }
      
      it "should return 'void method()'" do
        subject.should eq 'void method()'
      end
    end
    
    context "when the str is ' * API comment continues  '" do
      let(:str) { ' * API comment continues  ' }
      
      it "should return ''" do
        subject.should eq ''
      end
    end
    
    context "when the str is ' */  '" do
      let(:str) { ' */  ' }
      
      it "should return ''" do
        subject.should eq ''
      end
    end
  end
  

end

