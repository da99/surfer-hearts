
require "./spec_helper"
require "http/client"


describe "404 page" do
  it "responds with a 404 status code" do
    response = HTTP::Client.get "http://localhost:4567/not.found"
    assert response.status_code == 404
  end

  it "renders 404.html when no page is found" do
    response = HTTP::Client.get "http://localhost:4567/not.found"
    assert response.body.to_s == File.read("./Public/404.html")
  end
end # describe
