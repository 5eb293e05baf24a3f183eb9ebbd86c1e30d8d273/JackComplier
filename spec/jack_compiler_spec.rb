# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'jack_compiler'

describe JackCompiler do
  MULTI_FILES_DIR = "#{Dir.getwd}/spec/filemocks/three_jack_files"
  SINGLE_FILE_PATH = "#{Dir.getwd}/spec/filemocks/single_jack_file/source.jack"
  
  before(:each) do
    @jack_compiler = JackCompiler.new path_input
  end

  describe "globname" do
    subject { @jack_compiler.globname }
    
    context "When the path input is a directory" do
      let(:path_input) { MULTI_FILES_DIR }
      
      it "should equal to the 'input/*.jack'" do
        subject.should eq "#{path_input}/*.jack"
      end
    end

    context "When the path input is a filename" do
      let(:path_input) { SINGLE_FILE_PATH }
      
      it "should equal to the file name" do
        subject.should eq path_input
      end
    end    
  end
  
  describe "run" do
    subject { @jack_compiler.run }
    
    context "when there're 3 .jack files in the input dir" do
      before do
        CompileEngine.any_instance.stub(:compile_class).and_return("<class>this proves I can write XML</class>")
      end
      let(:path_input) { MULTI_FILES_DIR } 
      
      it "should produce three .xml files in the input dir" do
        subject
        Dir.glob("#{MULTI_FILES_DIR}/*.xml").size.should eq 3
      end
      
      it "should produce the .xml files with the same names as the source" do
        subject
        Dir.glob("#{MULTI_FILES_DIR}/*.xml").should include(
          "#{MULTI_FILES_DIR}/source0.xml",
          "#{MULTI_FILES_DIR}/source1.xml",
          "#{MULTI_FILES_DIR}/source2.xml")
      end
      
      it "should write something on those .xml files" do
        subject
        Dir.glob("#{MULTI_FILES_DIR}/*.xml") do |filename|
          xml_file= File.open(filename)
          xml_file.read.should eq "<class>this proves I can write XML</class>"
          xml_file.close
        end        
      end
      
      after(:each) do
        Dir.glob("#{MULTI_FILES_DIR}/*.xml") do |filename|
          File.delete filename
        end
      end
    end
  end
  
end

