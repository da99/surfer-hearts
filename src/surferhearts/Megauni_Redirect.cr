
module SurferHearts
  class Megauni_Redirect

    include HTTP::Handler

    def call(ctx)
      return call_next(ctx) if DA.is_development?

      host = ctx.request.host
      path = ctx.request.path

      if host == "www.megauni.com" && !DA.is_development?
        return call_next(ctx)
      end

      new_address = "http://www.megauni.com/surferhearts"
      new_path = if path == "/"
                   new_address
                 else
                   File.join new_address, path
                 end


      return DA_Server.redirect_to(301, new_path, ctx)
    end # === def call

  end # === class Megauni_Redirect
end # === module SurferHearts
