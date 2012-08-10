# To change this template, choose Tools | Templates
# and open the template in the editor.
$LOAD_PATH << File.dirname(__FILE__)
require "compile_engine"
require "tokenizer"

class JackCompiler
  # For rspec test purpose only
  attr_reader :input_dir_name
  
  def initialize path_input
    if File.directory? path_input
      @input_dir_name = path_input
    else
      @input_dir_name = File.dirname path_input
    end
    
    @tokenizer = Tokenizer.new
  end
  
  def run
    Dir.glob("#{@input_dir_name}/*.jack") do |filename|
      compiled_file = File.open("#{@input_dir_name}/#{File.basename(filename, ".jack")}.xml", "w")  
      begin
        tokens = @tokenizer.run filename
      rescue SyntaxError => e
        puts "In file '#{filename}', " + e.message
      end
      compiled_file.print CompileEngine.new(tokens).run()
      compiled_file.close
    end
  end
end

if __FILE__ == $0
  x = JackCompiler.new ARGV[0].gsub("\\", '/')
  x.run 
end
