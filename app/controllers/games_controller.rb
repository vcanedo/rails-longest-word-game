require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @grid = params[:grid]
    @answer = params[:word]
    if english_word == false
      @result = "Sorry but #{@answer} does not seem to be a valid English word..."
    elsif exists == false
      @result = "Sorry but #{@answer} can't be built out of #{@grid}"
    else
      @result = "Congratulations! #{@answer} is a valid word"
    end
  end

  def exists
    @grid.exists(@answer)
  end

  def english_word
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    word_dictionary = url.read
    word = JSON.parse(word_dictionary)
    word[:found]
  end

end
