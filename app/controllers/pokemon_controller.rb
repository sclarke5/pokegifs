class PokemonController < ApplicationController
  def show
    pokedex_res = HTTParty.get("https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json")
    pokedex_body = JSON.parse(pokedex_res.body)

    input = params[:id]


    pokedex_body["pokemon"].each do |i|
      if input.to_i == i["id"]
        @pokemon_id = i["id"]
        @pokemon_name = i["name"]
        @pokemon_type = i["type"]
      elsif input.to_i == 0
        if input.capitalize == i["name"]
          @pokemon_id = i["id"]
          @pokemon_name = i["name"]
          @pokemon_type = i["type"]
        end
      end
    end

    # if newID > 0
    # @found = pokedex_body["pokemon"].find_by(id: "id")
    # @found_id = @found['id']
    # @pokemon_id = pokedex_body["pokemon"][id.to_i-1]["id"]
    # @pokemon_name = pokedex_body["pokemon"][id.to_i-1]["name"]
    # @pokemon_type = pokedex_body["pokemon"][id.to_i-1]["type"]
    # else
    # @pokemon_id = pokedex_body["pokemon"]['id']["id"]
    # @pokemon_name = pokedex_body["pokemon"]['name']["name"]
    # @pokemon_type = pokedex_body["pokemon"]['name']["type"]

    name = @pokemon_name
    key = ENV["GIPHY_KEY"]
    gif_response = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{key}&q=#{name}&rating=g")
    gif_body = JSON.parse(gif_response.body)
    @gif_url = gif_body["data"][0]["images"]["original"]["url"]

    respond_to do |wants|
      wants.html { render :show }
      wants.json { render json: {
       "id": pokemon_id,
       "name": pokemon_name,
       "types": pokemon_type,
       "gif": gif_url}}
    end
      # wants.json { render json: {
      #   "id": @pokemon_id,
      #   "name": @pokemon_name,
      #   "types": @pokemon_type,
      #   "gif": @gif_url
      # }

    # render json: {    "id": @pokemon_id,
    #                   "name": @pokemon_name,
    #                   "types": @pokemon_type,
    #                   "gif": @gif_url}


  end
end
