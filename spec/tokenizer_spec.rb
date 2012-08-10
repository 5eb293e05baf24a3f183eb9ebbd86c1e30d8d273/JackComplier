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
        subject.should eq [["keyword", "class", 1], ['identifier', "SimpleTest", 1],["symbol", "{", 1], ["symbol", "}", 3]]
      end
    end
    
    context "when the input file 'SimpleTestWithVarDec.jack'" do  
      let(:input_filename) { "#{Dir.getwd}/spec/filemocks/single_jack_file/SimpleTestWithVarDec.jack" }
      
      it "should produce correct tokens" do
        subject.should eq [["keyword", "class", 1], ['identifier', "SimpleTestWithVarDec", 1], ["symbol", "{", 1], ["keyword", "field", 2], ["keyword", "int", 2], ['identifier', "x", 2], ["symbol", ",", 2], ['identifier', "y", 2], ["symbol", ";", 2], ["symbol", "}", 3]]
      end
    end
    
    context "when the input file 'SimpleTestWithVarDecMethondDec.jack'" do
      let(:input_filename) { "#{Dir.getwd}/spec/filemocks/single_jack_file/SimpleTestWithVarDecMethondDec.jack" }
      
      it "should produce correct tokens" do
        subject.should eq [["keyword", "class", 1], ['identifier', "SimpleTestWithVarDecMethondDec", 1], ["symbol", "{", 1], ["keyword", "field", 2], ["keyword", "int", 2], ['identifier', "x", 2], ["symbol", "=", 2], ["int_const", "6", 2], ["symbol", ",", 2], ['identifier', "y", 2], ["symbol", ";", 2], ["keyword", "method", 4], 
          ["keyword", "void", 4], ["identifier", "dispose", 4], ["symbol", "(", 4], ["symbol", ")", 4], ["symbol", "{", 4], ["keyword", "do", 5], ["identifier", "Memory", 5], 
          ["symbol", ".", 5], ["identifier", "deAlloc", 5], ["symbol", "(", 5], ["identifier", "x", 5], ["symbol", ")", 5], ["symbol", ";", 5], ["keyword", "return", 6], ["symbol", ";", 6], ["symbol", "}", 7], ["symbol", "}", 8]]
      end
    end
    
    context "when the input file 'SimpleTestWithVarDecMethondDecWithComments.jack'" do
      let(:input_filename) { "#{Dir.getwd}/spec/filemocks/single_jack_file/SimpleTestWithVarDecMethondDecWithComments.jack" }
      
      it "should produce correct tokens" do
        subject.should eq [["keyword", "class", 9], ['identifier', "SimpleTestWithVarDecMethondDecWithComments", 9], ["symbol", "{", 9], ["keyword", "field", 10], ["keyword", "int", 10], ['identifier', "x", 10], ["symbol", "=", 10], ["str_const", '"long value"', 10], ["symbol", ",", 10], ['identifier', "y", 10], ["symbol", ";", 10], ["keyword", "method", 12], 
          ["keyword", "void", 12], ["identifier", "dispose", 12], ["symbol", "(", 12], ["symbol", ")", 12], ["symbol", "{", 12], ["keyword", "do", 13], ["identifier", "Memory", 13], 
          ["symbol", ".", 13], ["identifier", "deAlloc", 13], ["symbol", "(", 13], ["identifier", "x", 13], ["symbol", ")", 13], ["symbol", ";", 13], ["keyword", "return", 14], ["symbol", ";", 14], ["symbol", "}", 15], ["symbol", "}", 16]]
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

