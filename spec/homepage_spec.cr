
require "./spec_helper"

describe "Homepage" do
  it "renders /index.html" do
    assert request("/") == public("/index.html")
  end

  it "renders /surferhearts/ as /index.html" do
    assert request("/surferhearts/") == public("/index.html")
  end

  it "renders: /robots.txt" do
    assert request("/robots.txt") == public("/robots.txt")
  end
end # describe
