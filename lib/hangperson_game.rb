class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  attr_accessor :word, :guesses, :wrong_guesses

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess letter
    raise ArgumentError unless letter =~ /[A-Za-z]/
    return false if @guesses.include?(letter) || @wrong_guesses.include?(letter) || ('A'..'Z').include?(letter)
    if @word.include? letter
      @guesses << letter
    else
      @wrong_guesses << letter
    end
  end
  
  def check_win_or_lose
    if @word == word_with_guesses
      :win
    elsif @wrong_guesses.size == 7
      :lose
    else
      :play
    end
  end

  def word_with_guesses
    @word.split('').each_with_object('') do |letter, output|
      if @guesses.include?(letter)
        output << letter
      else
        output << '-'
      end
    end
  end
end
