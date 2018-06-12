
module SurferHearts
  class Archive

    include HTTP::Handler

    @public_file_handler : HTTP::Handler
    @dir : String

    def initialize
      @dir = if DA.is_development?
               File.expand_path(
                 File.dirname(Process.executable_path.not_nil!) + "/../Public"
               )
            else
              DA_Deploy::App.new("surferhearts").public_dir
            end
      @public_file_handler = DA_Server::Public_Files.new(@dir)
    end # === def initialize

    def call(ctx)
      path = ctx.request.path

      case
      when path == "/surferhearts"
        path = "/index"

      when path == "/surferhearts/rss"
        return DA_Server.redirect_to(302, "/surferhearts/rss.xml", ctx)

      when path.index("/surferhearts") == 0
        path = path.sub("/surferhearts", "")

      end # case

      if !File.file?(File.join(@dir, path))
        path = "#{path}.html"
      end

      ctx.request.path = path
      return @public_file_handler.call(ctx)

      return call_next(ctx)
    end # === def call

  end # === class Surfer_Hearts
end # === module MEGAUNI
