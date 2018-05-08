class PokemonController < ApplicationController
  def show
    res = HTTParty.get("https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json")
    body = JSON.parse(res.body)
    id = params[:id]



    render json: {    "id": body["pokemon"][id.to_i-1]["id"],
                      "name": body["pokemon"][id.to_i-1]["name"],
                      "types": body["pokemon"][id.to_i-1]["type"]
                      }
  end
end
