require "spec_helper"

describe VraptorScaffold::HttpRequest do
  
  before :each do
    ENV['http_proxy'] = "http://google.com"
  end

  after :each do
    ENV.delete 'http_proxy'
  end

  it "should use 'http_proxy' env when it is present" do
    http = VraptorScaffold::HttpRequest.open_session "ajax.googleapis.com"
    http.get("/ajax/libs/jquery/1/jquery.min.js") do |response|
      response.should_not be_empty
    end
  end

end