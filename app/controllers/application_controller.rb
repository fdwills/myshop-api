class ApplicationController < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/../views'

  configure do
  end

  before do
  end

  after do
  end

  helpers do
    def render_error(error_code, error_message, error_details = nil)
      @error_code = error_code
      @error_message = error_code
      @error_details = error_details
      jbuilder :'application/error'
    end
  end

  private

end
