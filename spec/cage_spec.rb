require 'spec_helper'
require 'rails_helper'
RSpec.describe Api::V1::CagesController, type: :controller do

  it "Creates valid response structure" do
    post :create, params: {max_capacity: 3, status: "ACTIVE" }
    response_body = JSON.parse(response.body)
    cageID = response_body["data"]["id"]
    expect(response_body.keys).to eql ["status", "message", "data"]
  end
  it "Handles missing max_capacity" do
    post :create, params: {status: "ACTIVE" }
    response_body = JSON.parse(response.body)
    expect(response_body["status"]).to eq "ERROR"
    expect(response_body["message"]).to eq "Cage entry must have max_capacity variable"
  end
  it "Handles missing status" do
    post :create, params: {max_capacity: 3}
    response_body = JSON.parse(response.body)
    expect(response_body["status"]).to eq "ERROR"
    expect(response_body["message"]).to eq "Cage entry must have status variable"
  end
end
