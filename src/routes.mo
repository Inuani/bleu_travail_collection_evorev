
import Router       "mo:liminal/Router";
import RouteContext "mo:liminal/RouteContext";
import Liminal      "mo:liminal";
import Rave1 "rave_1";
// import Evoli "evoli";


module Routes {
  public func routerConfig() : Router.Config {
    {
      prefix              = null;
      identityRequirement = null;
      routes = [
        Router.getQuery("/",
          func(ctx: RouteContext.RouteContext) : Liminal.HttpResponse {
            let testHtml = "<!DOCTYPE html>"
                  # "<html lang='fr'>"
                  # "<head>"
                  # "    <meta charset='UTF-8'>"
                  # "    <meta name='viewport' content='width=device-width, initial-scale=1.0'>"
                  # "    <title>Alleret 2025</title>"
                  # "</head>"
                  # "<body style='font-family: Arial; text-align: center; padding: 50px;'>"
                  # "    <div style='margin-bottom: 20px;'>"
                                # "        <a href='/collection' style='text-decoration: none;'>"
                                # "            <button style='background-color: #5a368e; color: white; padding: 12px 24px; margin: 0 10px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px;'>Voir collection été 2025</button>"
                                # "        </a>"
                                # "        <a href='https://6xj5i-zaaaa-aaaas-aabiq-cai.raw.icp0.io/' style='text-decoration: none;'>"
                                # "            <button style='background-color: #7d5ba6; color: white; padding: 12px 24px; margin: 0 10px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px;'>Voir collection été 2024</button>"
                                # "        </a>"
                                # "    </div>"
                  # "    <div style='display: flex; align-items: center; justify-content: center; margin-bottom: 20px;'>"
                  # "        <img src='/logo.webp' alt='logo asso petit prince' style='width: 150px; height: auto; margin-right: 15px;'/>"
                  # "        <h1 style='color: #5a368e; margin: 0;'>Journal été 2025 des étoiles d'Alleret</h1>"
                  # "    </div>"
                  # "    <div class='jscf' data-cf-display-id='3q8MenX'></div>"
                  # "    <script>"
                  # "        window.cfAsyncInit = function() { "
                  # "            cfLoader.init(document.getElementsByClassName('jscf')); "
                  # "        };"
                  # "    </script>"
                  # "    <script async src='https://platform.contentfry.com/sdk/embed.js'></script>"
                  # "</body>"
                  # "</html>";
            ctx.buildResponse(#ok, #html(testHtml))
          }
        ),
        Router.getQuery("/rave_1",
                    func(ctx: RouteContext.RouteContext) : Liminal.HttpResponse {
                        let raveHtml = Rave1.html();
                        ctx.buildResponse(#ok, #html(raveHtml))
                    }
                ),
        //  Router.getQuery("/evoli",
        //             func(ctx: RouteContext.RouteContext) : Liminal.HttpResponse {
        //                 let evoliHtml = Evoli.html();
        //                 ctx.buildResponse(#ok, #html(evoliHtml))
        //             }
        //         ),
        Router.getQuery("/{path}",
          func(ctx) : Liminal.HttpResponse {
            ctx.buildResponse(#notFound, #error(#message("Not found")))
          }
        ),
      ];
    }
  }
}
