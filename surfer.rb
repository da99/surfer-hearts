
require 'sinatra'
require 'open-uri'

configure do
  S3_PREFIX = "http://surferhearts.s3.amazonaws.com/public"
  REDIS = if ENV["REDISTOGO_URL"]
            require 'redis'
            uri = URI.parse(ENV["REDISTOGO_URL"])
            Redis.new(:host => uri.host, :port => uri.port, :password => uri.password) 
          else
            false
          end
end

def get_file file_path
  r_key = "file_" + file_path.gsub(/[^a-z0-9A-Z]{1,}/, '_')
  return REDIS.get(file_path) if REDIS
  
  url = File.join( S3_PREFIX, file_path)
  contents = open(url) { |file| file.read } 
  
  REDIS.set( r_key, contents) if REDIS

  contents
end

get '/' do
  get_file 'index.html'
end

%w{ search index about blog  }.each { |file|
  get "/#{file}.html" do
    redirect "/#{file}/", 301
  end
  
  get "/#{file}/" do
    get_file "#{file}.html"
  end
}

%w{ media javascripts }.each { |prefix|
  get "/#{prefix}/*"  do
    url      = File.join( S3_PREFIX, prefix, params[:splat] )
    redirect url, 301
  end
}

%w{ blog heart_link heart_links }.each { |url|
  get "/#{url}" do
    redirect "/#{url}/", 301
  end

  get( "/#{url}/*" ) do
    
    splat = params[:splat].to_s.strip
    if splat.empty?
      splat = "/#{url}/index.html"
    end
    
    get_file splat
  end
}
