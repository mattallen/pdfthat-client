require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Pdfth.atRubyClient" do
  context 'defaults' do
    it "should set it's default URL" do
      Pdfthat.base_uri.should == "http://pdfth.at"
    end
    it "should set the default timeout to 10 seconds" do
      Pdfthat.default_options[:timeout].should == 10000
    end
    it "should default to development" do
      Pdfthat.api_uri.should == "/api/v1/development"
    end
    it "should allow development to be over-written" do
      Pdfthat.configure do |pdf|
        pdf.production true
      end
      Pdfthat.api_uri.should == "/api/v1"
    end
  end
  context '#get_document' do
    it "should fail without a token" do
      Pdfthat.get_document(:id => "abc").should == false
    end
    it "should pass with a token" do
      Pdfthat.configure do |pdf|
        pdf.token "629f29cb8d7c3de87fc248ea400b679688b3d5a128c01c981c"
        pdf.base_uri "http://pdf.local"
      end
      Pdfthat.get_document(:id => "2f5321a0-0163-012d-412f-0026b0d759a2").should be_a(Hash)
    end
  end
  context '#create_document' do
    it "should fail without a token" do
      Pdfthat.configure do |pdf|
        pdf.token = nil
      end
      Pdfthat.create_document(:document => {:url => "http://google.com.au/"}).should == false
    end
  end
end
