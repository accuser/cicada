require 'rubygems'
require 'sinatra'
require 'chunky_png'
require 'haml'
require 'sass'

set :haml, :format => :html5

class CicadaApp < Sinatra::Base
  get '/' do
    srand
    haml :index
  end

  PRIMES = [ 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97 ].freeze

  get '/:id.png' do
    srand(params[:id].to_i)
      
    prime = PRIMES[rand(PRIMES.size)]  
    color = ChunkyPNG::Color.rgba(rand(ChunkyPNG::Color::MAX), rand(ChunkyPNG::Color::MAX), rand(ChunkyPNG::Color::MAX), 128)

    png = ChunkyPNG::Image.new(prime, 1, ChunkyPNG::Color::TRANSPARENT)
    
    for x in 0..(prime / 2)
      png[x, 0] = color
    end
  
    content_type 'image/png', :charset => 'utf-8'
    png.to_blob
  end
end
