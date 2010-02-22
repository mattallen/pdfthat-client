require 'httparty'
class Pdfthat
  include HTTParty
  class << self
    attr :token,true
    attr :production,true
    
    def production(d)
      @production = d
    end
  
    def token(t)
      @token = t
    end
    
    def default_options
      @default_options[:timeout]  ||= 10000
      @default_options[:base_uri] ||= "http://pdfth.at"
      super
    end

    def configure
      yield self
    end
    
    def api_uri
      dev_uri = @production == true ?  "" :  "/development"
      "/api/v1#{dev_uri}"
    end

    def create_document(options)
      return false unless @token
      results = post(api_uri + "/documents.json", :query => options.merge(:token => @token))
      return results
    end
    def get_document(options)
      return false unless @token
      results = get(api_uri + "/documents/#{options[:id]}.json", :query => options.merge(:token => @token))
      return results
    end
  end
end
# Pdfthat.configure do |pdf|
#   pdf.token = "629f29cb8d7c3de87fc248ea400b679688b3d5a128c01c981c"
#   pdf.default_options = {:timeout => 1}
#   pdf.base_uri 'http://pdf.local'
# 
# end
# p = Pdfthat.new
# puts p.get_document(:id => "2f5321a0-0163-012d-412f-0026b0d759a2")
