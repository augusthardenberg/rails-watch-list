require "json"
require "open-uri"

url = "https://tmdb.lewagon.com/movie/top_rated"

url = "https://tmdb.lewagon.com/movie/top_rated"
data = JSON.parse(URI.open(url).read)

puts "cleaning Lists"
List.destroy_all

puts "cleaning DB"
Movie.destroy_all

puts "loading DB with top-rated movies"
data["results"].each do |movie|
  image_url = movie["poster_path"] && "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}"

  Movie.create!(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: image_url,
    rating: movie["vote_average"]
  )
end
