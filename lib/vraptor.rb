require 'rubygems'
require 'thor'
require 'thor/actions'
require 'thor/group'

class Vraptor < Thor::Group
	include Thor::Actions
	class_option :test_framework
	#argument :name
	
	def self.execute(args)
		command = "java -jar " + jar_path + " " + args.join(" ")
		exec(command)	
   	 end
   	 	
   	 def self.jar_path
       	File.expand_path(__FILE__ + "../../../lib/vraptor-scaffold.jar")
     end
     
     def self.source_root
        File.dirname(__FILE__)
     end
     
     def create_file_a
     	#template('templates/TemplateModel.ftl', "vraptor/lib/#{name}.rb") 
     end
end
