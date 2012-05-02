require "spec_helper"

describe VraptorScaffold::HttpRequest do

  before :all do
    @http_proxy = ENV['http_proxy']
  end

  after :all do
    ENV['http_proxy'] = @http_proxy
  end

  context "http proxy" do
    before :each do
      ENV['http_proxy'] = "http://google.com"
    end

    after :each do
      ENV.delete 'http_proxy'
    end

    it "should use 'http_proxy' env when it is present" do
      http = VraptorScaffold::HttpRequest.http
      http.should be_true http.proxy_class?
    end
  end

  context "no proxy" do

    before :each do
      ENV.delete 'http_proxy'
    end

    it "should not use proxy settings when no http_proxy env exists" do
      http = VraptorScaffold::HttpRequest.http
      http.should be_true !http.proxy_class?
    end
  end

  context "open session" do
    it "should open a http session" do
      http_request = mock(Net::HTTP)
      VraptorScaffold::HttpRequest.stub!(:http).and_return(http_request)
      http_request.stub!(:start).and_return(http_request)

      http = VraptorScaffold::HttpRequest.open_session "http://any_url/here"
      http.should be_true
    end
  end
end
