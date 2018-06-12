
require "da"
require "da_deploy"
require "da_server"
require "./surferhearts/Megauni_Redirect"
require "./surferhearts/Archive"

module SurferHearts
  extend self

  def service_run
    host       = DA.is_development? ? "localhost" : "0.0.0.0"
    port       = DA.is_development? ? 4567 : 350
    user       = DA.is_development? ? `whoami`.strip : "www-surferhearts"
    public_dir = File.join(File.dirname(Process.executable_path.not_nil!), "../Public")

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
