require 'pry-debugger'

# This class is complete. You do not need to alter this
class Card
  attr_accessor :rank, :value, :suit
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

  attr_accessor :unshuffled_deck, :shuffled_deck, :card1, :card2

  def initialize
    @shuffled_deck = []
    @unshuffled_deck = []
    @x = 0
  end

  def make_deck
    ranks = %w{2 3 4 5 6 7 8 9 10 J Q K A}
    suits = %w{Spades Hearts Diamonds Clubs}
    for suit in suits
      ranks.size.times do |i|
        @unshuffled_deck << Card.new(ranks[i], i+2, suit)
      end
    end
    @shuffled_deck = @unshuffled_deck.sort_by{rand}[0,52]
  end

  # Given a card, insert it on the bottom your deck
  def add_card(cards)
    @addhand1 = []
    @addhand2 = []
  end

  # Remove the top card from your deck and return it
  def deal_card
    @unshuffled_deck = @ad1 if @unshuffled_deck[-1] == nil
    @card1 = @unshuffled_deck[@x]
    @unshuffled_deck[@x] = nil
    return @card1
    @x+=1
  end

end

# You may or may not need to alter this class
class Player

  attr_accessor :hand, :name

  def initialize(name)
    @name = name
    @hand = Deck.new
  end
end


class War
  
  attr_accessor :player1, :player2, :deck

  def initialize(player1, player2)
    @player1 = Player.new(player1)
    @player2 = Player.new(player2)
    @deck = Deck.new
    @deck = @deck.make_deck
    for x in (0..51)
      @player1.hand.unshuffled_deck << @deck[x] if x < 26
      @player2.hand.unshuffled_deck << @deck[x] if x > 25
    end
    # You will need to shuffle and pass out the cards to each player
  end

  # You will need to play the entire game in this method using the WarAPI
  def play_game
    while @player1.hand > 0 && @player2.hand > 0
      hash = WarAPI.play_turn(@player1, @player1.hand.deal_card, @player2, @player2.hand.deal_card)
      @player1.hand.add_card(hash['@player1'])
      @player2.hand.add_card(hash['@player2'])
    end
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
