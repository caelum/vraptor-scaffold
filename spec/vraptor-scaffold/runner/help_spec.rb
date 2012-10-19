require "spec_helper"

describe VraptorScaffold::Runner::Help do

  before(:all) do
    @help = VraptorScaffold::Runner::Help
  end

  context "user asking to see vraptor help" do

    it "should be true when nil" do
      @help.help?(nil).should be_true
    end

    it "should be true when -h" do
      @help.help?('-h').should be_true
    end

    it "should be true when --help" do
      @help.help?('--help').should be_true
    end

    it "should be true when help" do
      @help.help?('help').should be_true
    end

    it "should be false otherwise" do
      @help.help?('scaffold').should be_false
    end

  end

end
