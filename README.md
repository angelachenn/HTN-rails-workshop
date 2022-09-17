# Build a Complete Web App with Ruby on Rails in Under an Hour!

[![forthebadge](http://forthebadge.com/images/badges/made-with-ruby.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/built-with-love.svg)](http://forthebadge.com)

Welcome to Hack the North 2022 and to this workshop! Ruby on Rails is a great tool to go with to kickstart your hackathon project and finish a working prototype within a short amount of time, so you have time for all the bells and whistles. In this workshop, you'll build your own web application from start to finish in only an hour with Rails!

 ![image](https://hackthenorth.com/preview_img.png)

a47616f0e20245230763f9dfd4c5616a

# Table of contents
- [Installation](#installation)
- [Modifications for Repl Users](#modifications-for-repl-users)
- [Code from Slides](#code-from-slides)
  - [Slide 31](#slide-31)
  - [Slide 32](#slide-32)
  - [Slide 33](#slide-33)
  - [Slide 39](#slide-39)
  - [Slide 40](#slide-40)
  - [Slide 41](#slide-41)
  - [Slide 42](#slide-42)
  - [Slide 43](#slide-43)
- [Resources](#resources)
- [Closing Words](#closing-words)

# Installation

Before you start, please make sure that you've checked out the [Hack Pack](https://docs.google.com/document/d/1sAZpDzUjBz2eCnHdzqziLwDhxUVUoV5uFNlHZs9oEL8/edit?usp=sharing) for this workshop. This includes instructions on how to install Ruby, SQLite, and Rails.

Additionally, please run `bundle install` (mentioned early on in the slides).

# Modifications for Repl Users
[Work in Progress]

After cloning, please run bundle install as normal.

For every other command ran in the CLI for the remainder of the workshop, please insert "bundle exec" in front.

[(Back to top)](#table-of-contents)

# Code from Slides
## Slide 31
Navigate to the migration file created under db/migrate `db/migrate`:

``` ruby
class CreateProductionCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :production_companies do |t|
      t.string   :name         # company.name
      t.string   :homepage     # company.homepage

      t.timestamps
    end
  end
end
```

[(Back to top)](#table-of-contents)

## Slide 32
Navigate to the migration file (for movies) created under db/migrate `db/migrate`:

``` ruby
class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.belongs_to :production_company
      t.string     :title        # movie.title
      t.text       :overview     # movie.overview
      t.string     :poster       # movie.poster
      t.date       :release_date # movie.release_date
      t.float      :ratings      # movie.vote_average
      t.float      :review       # YOUR REVIEW (1.0-5.0)
      t.boolean    :watched      # true if seen

      t.timestamps
    end
  end
end
```

[(Back to top)](#table-of-contents)

## Slide 33

Inside the model created at `app/models/movie.rb`:

```ruby
class Movie < ApplicationRecord
  belongs_to :production_company

  validates :review, numericality: { in: 1.0..10.0 }, :allow_nil => true
end
```

[(Back to top)](#table-of-contents)

## Slide 39
Navigate to `app/controllers/movies_controller.rb`:

```ruby
class MoviesController < ApplicationController

  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
```

[(Back to top)](#table-of-contents)

## Slide 40
Still inside `app/controllers/movies_controller.rb`:

```ruby
def new
  @movie = Movie.new
end

def create
  @movie = Movie.new(movie_params)

  if @movie.save
    redirect_to @movie
  else
    render :new, status: :unprocessable_entity
  end
end
 ```
 
[(Back to top)](#table-of-contents)

## Slide 41
Still inside `app/controllers/movies_controller.rb`:
```ruby
def edit
  @movie = Movie.find(params[:id])
end

def update
  @movie = Movie.find(params[:id])

  if @movie.update(movie_params)
    redirect_to @movie
  else
    render :edit, status: :unprocessable_entity
  end
end
```
[(Back to top)](#table-of-contents)

## Slide 42
Inside `app/controllers/movies_controller.rb`:
```ruby
def destroy
  @movie = Movie.find(params[:id])
  @movie.destroy!

  redirect_to movies_path
end
```
At the very end of the same file, paste this:

```ruby
private
  def movie_params
    params.require(:movie).permit(:watched,:review)
  end

```

[(Back to top)](#table-of-contents)

## Slide 43
Under `config/routes.rb`, paste:
```ruby
Rails.application.routes.draw do
  resources :movies
  root "movies#index"
end

```


[(Back to top)](#table-of-contents)

# Resources
[The Movie Database Api](https://developers.themoviedb.org/3/getting-started/introduction)
[Ruby Wrapper for TMDB](https://github.com/ahmetabdi/themoviedb)

[(Back to top)](#table-of-contents)

# Closing Words
Thank you so much for checking us out at Hack The North 2022, or on the interwebs. We hope you had as much fun as we did making this workshop. We'd love to see your modifications!

With love,
Angela and Adison

[(Back to top)](#table-of-contents)
