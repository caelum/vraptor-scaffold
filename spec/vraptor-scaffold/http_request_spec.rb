require "spec_helper"

describe VraptorScaffold::HttpRequest do
  
  before :each do
    @http_proxy = ENV['http_proxy']
    ENV['http_proxy'] = "http://google.com"
  end

  after :each do
    ENV.delete 'http_proxy'
    ENV['http_proxy'] = @http_proxy
  end

  it "should use 'http_proxy' env when it is present" do
    http = VraptorScaffold::HttpRequest.http
    http.should be_true http.proxy_class?
  end

  context "no proxy" do

    before :each do
      ENV.delete 'http_proxy'
    end

    after :each do
      ENV['http_proxy'] = @http_proxy
    end

    it "should not use proxy settings when no http_proxy env exists" do
      http = VraptorScaffold::HttpRequest.http
      http.should be_true !http.proxy_class?
    end
  end

end
