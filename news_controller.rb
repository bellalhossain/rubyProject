class NewsController < ApplicationController
  def news
  end
end

def search
    countries = find_country(params[:country])
    unless countries
      flash[:alert] = 'Country not found'
      return render action: :index
    end
    @country = countries.first
    @weather = find_weather(@country['capital'], @country['alpha2Code'])
  end
# app/controllers/travel_controller.rb
  private

  def request_api(url)
    response = Excon.get(
      url,
      headers: {
        'X-RapidAPI-Host' => URI.parse(url).host,
        'X-RapidAPI-Key' => ENV.fetch( "7a2aedfcb8msh5b55ffe49797221p1c188cjsnb5411e4ffa96")
      }
    )

    return nil if response.status != 200

    JSON.parse(response.body)
  end

  def find_country(name)
    request_api(
      "https://restcountries-v1.p.rapidapi.com/name/#{URI.encode(name)}"
    )
  end