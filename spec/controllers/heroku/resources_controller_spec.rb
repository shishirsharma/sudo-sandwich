require 'rails_helper'

RSpec.describe Heroku::ResourcesController do
  describe 'POST /heroku/resources' do
    it 'returns a 202' do
      http_login(ENV['SLUG'], ENV['PASSWORD'])

      post :create

      expect(response.code).to eq("200")
    end

    it 'returns the correct json response' do
      http_login(ENV['SLUG'], ENV['PASSWORD'])
      heroku_uuid = "123-ABC-456-DEF"
      expected_response = {
        id: heroku_uuid,
        config: {
          SUDO_SANDWICH_COMMAND: "Make me a PB&J!"
        },
        message: "Thanks for using Sudo Sandwich."
      }

      post :create, params: { "uuid" => heroku_uuid }

      expect(parsed_response_body).to eq(expected_response)
    end
  end

  describe 'POST /heroku/resources' do
    it 'returns a 204' do
      http_login(ENV['SLUG'], ENV['PASSWORD'])

      delete :destroy, params: { "id" => "123-ABC" }

      expect(response.code).to eq("204")
    end
  end

    def parsed_response_body
      JSON.parse(response.body, symbolize_names: true)
    end
end
