# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require "themoviedb"

Tmdb::Api.key("API_KEY")

Tmdb::Movie.popular.each do |m|
  movie = Tmdb::Movie.detail(m.id)
  company = movie["production_companies"].first

  production_info = {
    name: company.nil? ? "No production company" : company["name"],
    homepage: company.nil? ? "N/A" : Tmdb::Company.detail(company["id"])["homepage"]
  }

  @production_company = ProductionCompany.where(name: production_info[:name]).first_or_create(production_info)

  watched = [true, false].sample
  
  movie_info = {
    title: movie["title"],
    overview: movie["overview"],
    poster: "https://image.tmdb.org/t/p/w500"+movie["poster_path"],
    release_date: movie["release_date"],
    ratings: movie["vote_average"],
    production_company_id: @production_company.id,
    watched: watched,
    review: watched ? rand(1.0..5.0) : nil
  }

  Movie.create(movie_info)
end
