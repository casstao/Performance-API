require 'spec_helper'
require 'rails_helper'
RSpec.describe Api::V1::DinosController, type: :controller do

  it "Dino failed request without Cage ID" do
    post :create, params: {name:"Tim", species: "Brachiosaurus" }
    response_body = JSON.parse(response.body)
    expect(response_body["status"]).to eql "ERROR"
    expect(response_body["message"]).to eql "Parameter inputs are invalid"



  end
end
