require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe Vraptor do
    it "should call vraptor scaffold jar" do
    	projectName = "vraptor"
    	jar = File.expand_path(__FILE__ + "../../../lib/vraptor-scaffold.jar")
    	command = "java -jar " + jar + " " + projectName
    	Vraptor.should_receive(:exec).with(command) 
    	Vraptor.execute([projectName])
	end
	
	it "testing thor" do
		puts Vraptor.source_root
		puts Vraptor.new.create_file_a
	end
end
