
require "./spec_helper"

describe "404 errors" do
  it "responds with 404 status code" do
    assert(request!("/typo.err").status_code == 404)
  end

  it "renders /404.html" do
    assert(request_body!("/typo/err") == public!("/404.html"))
  end
end # describe
