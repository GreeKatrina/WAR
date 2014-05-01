require 'pry-debugger'

# This class is complete. You do not need to alter this
class Card
  # Rank is the rank of the card, 2-10, J, Q, K, A
  # Value is the numeric value of the card, so J = 11, A = 14
  # Suit is the suit of the card, Spades, Diamonds, Clubs or Hearts
  def initialize(rank, value, suit)
    @rank = rank
    @value = value
    @suit = suit
  end
end

class Deck

  attr_accessor :unshuffled_deck, :shuffled_deck, :player1_hand, :player2_hand

  def initialize
    @shuffled_deck = []
    @unshuffled_deck = []
    @player1_hand = []
    @player2_hand = []
  end

  def make_deck
    ranks = %w{2 3 4 5 6 7 8 9 10 J Q K A}
    suits = %w{Spades Hearts Diamonds Clubs}
    for suit in suits
      ranks.size.times do |i|
        @unshuffled_deck << Card.new(ranks[i], i+2, suit)
      end
    end
    @unshuffled_deck
  end

  def shuffle_deck
    @shuffled_deck = @unshuffled_deck.sort_by{rand}[0,52]
    @player1_hand << @shuffled_deck[0..25]
    @player2_hand << @shuffled_deck[26..52]
  end
binding.pry
  # Given a card, insert it on the bottom your deck
  def add_card(cards)


  end

  # Remove the top card from your deck and return it
  def deal_card(player1_hand, player2_hand)

  end

end

# You may or may not need to alter this class
class Player
  def initialize(name)
    @name = name
    @deck = Deck.new
    @deck.make_deck
    @deck.shuffle_deck
  end
end


class War
  def initialize(player1, player2)
    @player1 = Player.new(player1)
    @player2 = Player.new(player2)
    # You will need to shuffle and pass out the cards to each player
  end

  # You will need to play the entire game in this method using the WarAPI
  def play_game
    WarAPI.play_turn(@player1, @player2)
  end

  def self.card
    hash = War.play_game
  end
end


class WarAPI
  # This method will take a card from each player and
  # return a hash with the cards that each player should receive
  def self.play_turn(player1, card1, player2, card2)
    if card1.value > card2.value
      {player1 => [card1, card2], player2 => []}
    elsif card2.value > card1.value || Rand(100).even?
      {player1 => [], player2 => [card2, card1]}
    else
      {player1 => [card1, card2], player2 => []}
    end
  end
end
