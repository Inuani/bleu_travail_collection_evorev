
import Router       "mo:liminal/Router";
import RouteContext "mo:liminal/RouteContext";
import Liminal      "mo:liminal";
import Evoli "evoli";
import Text "mo:new-base/Text";
import Nat "mo:base/Nat";
import Route "mo:liminal/Route";
import BleuCollection "bleu_collection";
import Debug "mo:base/Debug";


module Routes {
  public func routerConfig(engagementContract: Evoli.EngagementContract, canisterId: Text) : Router.Config {
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
                                # "        <a href='https://discord.gg/tmGKpqGCwX' style='text-decoration: none;'>"
                                # "            <button style='background-color: #0040a7; color: white; padding: 12px 24px; margin: 0 10px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px;'>Rejoins la communauté les collections d'Évorev</button>"
                                # "        </a>"
                                # "        <a href='http://" # canisterId # ".raw.icp0.io/collection' style='text-decoration: none;'>"
                                # "            <button style='background-color: #0040a7; color: white; padding: 12px 24px; margin: 0 10px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px;'>Voir la collection</button>"
                                # "        </a>"
                                # "    </div>"
                  # "    <div style='display: flex; align-items: center; justify-content: center; margin-bottom: 20px;'>"
                  # "        <img src='/logo.webp' alt='logo ordre d'Evorev style='width: 100px; height: auto; margin-right: 15px;'/>"
                  # "        <h1 style='color: #0040a7; margin: 0;'>Collection Ordre d'Évorev</h1>"
                  # "    </div>"
                  # "</body>"
                  # "</html>";
            ctx.buildResponse(#ok, #html(testHtml))
          }
        ),
        //  Router.getQuery("/evoli",
        //             func(ctx: RouteContext.RouteContext) : Liminal.HttpResponse {
        //                 let evoliHtml = Evoli.html();
        //                 ctx.buildResponse(#ok, #html(evoliHtml))
        //             }
        //         ),
        Router.getQuery("/bleu/{id}", func(ctx: RouteContext.RouteContext) : Liminal.HttpResponse {
                   Debug.print("HERE - /bleu/{id} route hit!");
                   let idText = ctx.getRouteParam("id");
                   Debug.print("idText from /bleu/{id}: " # idText);

                   let id = switch (Nat.fromText(idText)) {
                       case (?num) num;
                       case null {
                           Debug.print("Invalid ID format: " # idText);
                           let html = BleuCollection.generateNotFoundPage(0);
                           return ctx.buildResponse(#notFound, #html(html));
                       };
                   };

                   Debug.print("Successfully parsed ID: " # Nat.toText(id));
                   let html = BleuCollection.generateBleuPage(id);
                   ctx.buildResponse(#ok, #html(html))
               }),
               Router.getQuery("/collection", func(ctx: RouteContext.RouteContext) : Liminal.HttpResponse {
                   let html = BleuCollection.generateCollectionPage();
                   ctx.buildResponse(#ok, #html(html))
               }),
                       Router.getQuery("/evoli",
    func(ctx: RouteContext.RouteContext) : Liminal.HttpResponse {
        let html = Evoli.html(engagementContract);
        ctx.buildResponse(#ok, #html(html))
    }
),
Router.post("/engagement/engage", #syncUpdate(
  func<system>(ctx: RouteContext.RouteContext) : Liminal.HttpResponse {
    // Extract name from query parameters
    switch (Evoli.extractName(ctx.httpContext.request.url)) {
      case null {
        ctx.buildResponse(#badRequest, #text("{\"success\": false, \"message\": \"Il te faut un prénom\"}"))
      };
      case (?name) {
        if (Text.size(name) == 0) {
          ctx.buildResponse(#badRequest, #text("{\"success\": false, \"message\": \"Prénom ne peut pas être vide\"}"))
        } else if (Text.size(name) < 2) {
          ctx.buildResponse(#badRequest, #text("{\"success\": false, \"message\": \"Prénom doit être au moins 2 caractères\"}"))
        } else {
          let success = engagementContract.engage(name);

          if (success) {
            ctx.buildResponse(#ok, #text("{\"success\": true, \"message\": \"Bienvenue sur le projet, " # name # "!\"}"))
          } else {
            ctx.buildResponse(#badRequest, #text("{\"success\": false, \"message\": \"Prénom existe déjà. Utilise en un autre.\"}"))
          }
        }
      };
    }
  }
)),
        Router.getQuery("/{path}",
          func(ctx) : Liminal.HttpResponse {
            ctx.buildResponse(#notFound, #error(#message("Not found")))
          }
        ),
      ];
    }
  }
}
