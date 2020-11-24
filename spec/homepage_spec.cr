
require "./spec_helper"
require "http/client"

describe "Homepage" do
  it "it renders html" do
    response = HTTP::Client.get "http://localhost:4567/"
    assert response.body.to_s == File.read("./Public/index.html")
  end

  it "renders: robots.txt" do
    response = HTTP::Client.get "http://localhost:4567/robots.txt"
    assert response.body.to_s == File.read("./Public/robots.txt")
  end
end # describe
