
require "da"
require "da_deploy"
require "da_server"
require "./surferhearts/Megauni_Redirect"
require "./surferhearts/Archive"

module SurferHearts
  extend self

  def service_run(port : Int32 = 4567, user : String = `whoami`.strip)
    host       = DA.is_development? ? "localhost" : "0.0.0.0"
    public_dir = "./Public"

    DA_Server.new(
      host,
      port,
      user,
      [
        DA_Server::No_Slash_Tail.new,
        Megauni_Redirect.new,
        Archive.new,
        DA_Server::Public_Files.new(public_dir),
      ]
    ).listen
  end # === def service_run
end # === module Surferhearts
