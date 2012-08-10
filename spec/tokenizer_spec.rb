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
        subject.should eq [["keyword", "class"], ['identifier', "SimpleTest"],["symbol", "{"], ["symbol", "}"]]
      end
    end
    
    context "when the input file 'SimpleTestWithVarDec.jack'" do  
      let(:input_filename) { "#{Dir.getwd}/spec/filemocks/single_jack_file/SimpleTestWithVarDec.jack" }
      
      it "should produce correct tokens" do
        subject.should eq [["keyword", "class"], ['identifier', "SimpleTestWithVarDec"], ["symbol", "{"], ["keyword", "field"], ["keyword", "int"], ['identifier', "x"], ["symbol", ","], ['identifier', "y"], ["symbol", ";"], ["symbol", "}"]]
      end
    end
    
    context "when the input file 'SimpleTestWithVarDecMethondDec.jack'" do
      let(:input_filename) { "#{Dir.getwd}/spec/filemocks/single_jack_file/SimpleTestWithVarDecMethondDec.jack" }
      
      it "should produce correct tokens" do
        subject.should eq [["keyword", "class"], ['identifier', "SimpleTestWithVarDecMethondDec"], ["symbol", "{"], ["keyword", "field"], ["keyword", "int"], ['identifier', "x"], ["symbol", "="], ["int_const", "6"], ["symbol", ","], ['identifier', "y"], ["symbol", ";"], ["keyword", "method"], 
          ["keyword", "void"], ["identifier", "dispose"], ["symbol", "("], ["symbol", ")"], ["symbol", "{"], ["keyword", "do"], ["identifier", "Memory"], 
          ["symbol", "."], ["identifier", "deAlloc"], ["symbol", "("], ["identifier", "x"], ["symbol", ")"], ["symbol", ";"], ["keyword", "return"], ["symbol", ";"], ["symbol", "}"], ["symbol", "}"]]
      end
    end
    
    context "when the input file 'SimpleTestWithVarDecMethondDecWithComments.jack'" do
      let(:input_filename) { "#{Dir.getwd}/spec/filemocks/single_jack_file/SimpleTestWithVarDecMethondDecWithComments.jack" }
      
      it "should produce correct tokens" do
        subject.should eq [["keyword", "class"], ['identifier', "SimpleTestWithVarDecMethondDecWithComments"], ["symbol", "{"], ["keyword", "field"], ["keyword", "int"], ['identifier', "x"], ["symbol", "="], ["str_const", '"long value"'], ["symbol", ","], ['identifier', "y"], ["symbol", ";"], ["keyword", "method"], 
          ["keyword", "void"], ["identifier", "dispose"], ["symbol", "("], ["symbol", ")"], ["symbol", "{"], ["keyword", "do"], ["identifier", "Memory"], 
          ["symbol", "."], ["identifier", "deAlloc"], ["symbol", "("], ["identifier", "x"], ["symbol", ")"], ["symbol", ";"], ["keyword", "return"], ["symbol", ";"], ["symbol", "}"], ["symbol", "}"]]
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
        expect {subject}.to raise_error(SyntaxError, "invalid string '2x' at line 2")
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

