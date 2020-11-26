
require "da_spec"
require "http/client"

extend DA_SPEC

def request!(path)
  HTTP::Client.get("https://www.surferhearts.com#{path}")
end

def request_body!(path)
    request!(path).body.to_s
end

def public!(path)
  File.read("./Public#{path}")
end # def
