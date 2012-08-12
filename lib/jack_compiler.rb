# To change this template, choose Tools | Templates
# and open the template in the editor.
$LOAD_PATH << File.dirname(__FILE__)
require "compile_engine"
require "tokenizer"

class JackCompiler
  # For rspec test purpose only
  attr_reader :globname
  
  def initialize path_input
    if File.directory? path_input
      @globname = "#{path_input}/*.jack"
    else
      @globname = path_input
    end
    
    @tokenizer = Tokenizer.new
  end
  
  def run
    Dir.glob(@globname) do |filename|
      compiled_file = File.open("#{File.dirname(filename)}/#{File.basename(filename, ".jack")}.xml", "w")  
      begin
        compiled_code = CompileEngine.new(@tokenizer.run filename).run()
      rescue SyntaxError => e
        puts "In file '#{filename}', " + e.message
      end
      compiled_file.print compiled_code
      compiled_file.close
    end
  end
end

if __FILE__ == $0
  x = JackCompiler.new ARGV[0].gsub("\\", '/')
  x.run 
end
