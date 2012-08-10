# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'compile_engine'

describe CompileEngine do
  before(:each) do
    @compile_engine = CompileEngine.new tokens
  end

  describe "complie_class" do
    subject { @compile_engine.send :complie_class }
    
    context "when the tokens are from SimpleTest.jack" do
      let(:tokens) { [["keyword", "class"], ['identifier', "SimpleTest"],["symbol", "{"], ["symbol", "}"]] }
    
      it "should produce correct xmls" do
        pending
        subject.should eq "<class><keyword>class</keyword><identifier>SimpleTest</identifier>symbol>{</symbol><symbol>}</symbol></class>"
      end
    end
  end
  
  describe "expect_token_value" do
    subject { @compile_engine.send :expect_token_value, value, tokens.shift }
    
    context "when the value is 'class'" do
      let(:value) { 'class' }
      
      context "when the tokens is ['keyword', 'class']" do
        let(:tokens) { [['keyword', 'class']] }
        
        it "should produce correct xmls" do
          subject.should eq "<keyword>class</keyword>"
        end
      end
      
      context "when the token is ['identifier', 'class2']" do
        let(:tokens) { [['identifier', 'class2']] }
        
        it "should raise an error" do
          expect {subject}.to raise_error(RuntimeError, "expected '#{value}' but got '#{tokens[0][1]}'")
        end
      end
    end
  end
  
  describe "expect_token_type" do
    subject { @compile_engine.send :expect_token_type, type, tokens.shift }
    
    context "when the value is 'class'" do
      let(:type) { 'identifier' }
      
      context "when the tokens is ['identifier', 'Simpleclass']" do
        let(:tokens) { [['identifier', 'Simpleclass']] }
        
        it "should produce correct xmls" do
          subject.should eq "<identifier>Simpleclass</identifier>"
        end
      end
      
      context "when the token is ['symbol', ',']" do
        let(:tokens) { [['symbol', ',']] }
        
        it "should raise an error" do
          pending
          expect {subject}.to raise_error(RuntimeError, "expected identifier but got symbol ','")
        end
      end
    end
  end  
end

