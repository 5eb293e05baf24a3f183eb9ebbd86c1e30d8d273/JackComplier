# To change this template, choose Tools, Templates
# and open the template in the editor.

require 'lexical_elements'

describe LexicalElements do
  before(:each) do
 
  end
  
  describe "symbol_regex" do
    subject { LexicalElements.symbol_regex }
    
    it "should match the right symbols" do
      ['{', '}', '(', ')', '[', ']', '.', ',', ';', '+', '-', '*', '/', '&', '|', '<', '>', '=', '~'].each do |symbol|
        subject.match(symbol).should_not be_nil
      end   
    end
    
    it "should NOT match 'class'" do
      subject.match('class').should be_nil
    end
  end
  
  describe "str_const_regex" do
    subject { LexicalElements.str_const_regex }
    
    it "should match '\"this is a string!\"'" do
      subject.match('"this is a string!"').should_not be_nil
    end
    
    it "should NOT match 'this is a string!'" do
      subject.match('this is a string!').should be_nil
    end
    
    it "should NOT match 'x=y'" do
      subject.match('x=y').should be_nil
    end
  end
  
  describe "keyword_regex" do
    subject { LexicalElements.keyword_regex }
    
    it "should match the right keywords" do
      ['class','constructor','function','method','field','static','var','int','char','boolean','void','true','false','null','this','let','do','if','else','while','return'].each do |symbol|
        subject.match(symbol).should_not be_nil
      end   
    end
    
    it "should NOT match 'Simpleclass'" do
      subject.match('Simpleclass').should be_nil
    end
  end
  
  describe "identifier_regex" do
    subject { LexicalElements.identifier_regex }
    
    it "should match 'name'" do
      subject.match('name').should_not be_nil
    end
    
    it "should match 'x'" do
      subject.match('x').should_not be_nil
    end
    
    it "should NOT match '2name'" do
      subject.match('2name').should be_nil
    end
  end
  
  describe "int_const_regex" do
    subject { LexicalElements.int_const_regex }
    
    it "should match '6'" do
      subject.match('6').should_not be_nil
    end
    
    it "should match '2345'" do
      subject.match('2345').should_not be_nil
    end
    
    it "should NOT match '2name'" do
      subject.match('2name').should be_nil
    end
    
    it "should NOT match '123456'" do
      subject.match('123456').should be_nil
    end
  end

end

