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

  attr_accessor :unshuffled_deck, :shuffled_deck, :x, :emptyarray, :addhand

  def initialize
    @shuffled_deck = []
    @unshuffled_deck = []
    @addhand = []
    @emptyarray = []
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
  def add_card(card)
    @addhand = @addhand + card
  end

  # Remove the top card from your deck and return it
  def deal_card
    if @unshuffled_deck[-1] == nil
      @unshuffled_deck = @addhand
      @addhand = @emptyarray
      @x = 0
    end
    card = @unshuffled_deck[@x]
    @unshuffled_deck[@x] = nil
    @x+=1
    return card
  end
end

class Node
  attr_accessor :last, :start, :parent, :child, :card
  def initialize(params)
    params ||= nil
    @last = params[:last] # boolean
    @start = params[:start] # boolean
    @parent = params[:parent]
    @child = params[:child] ||= nil
    @card = params[:card]
  end
end

class Queue
  attr_accessor :last, :start, :counter
  def initialize
    @last = nil # node
    @start = nil # node
    @counter = 0
  end

  def play_card
    card = @start.card
    @start.start = false
    @start = @start.child
    @start.start = true
    @counter -= 1
    return card
  end

  def add_card(card)
    node = Node.new(last: true, start: false, parent: @last, card: card)
    if @start == nil
      node.start = true
      @start = node
    end
    if @last == nil
      @last = node
    else
      @last.child = node
      @last = node
    end
    @counter += 1
  end
end

# You may or may not need to alter this class
class Player

  attr_accessor :hand, :name

  def initialize(name)
    @name = name
    @hand = Queue.new
  end
end


class War

  attr_accessor :player1, :player2, :deck, :winner, :turns

  # Create a new deck in the Deck class
  # Make a new Queue instance for each player, which will be their hands
  def initialize(player1, player2)
    @player1 = Player.new(player1)
    @player2 = Player.new(player2)
    @deck = Deck.new
    @deck = @deck.make_deck
    @winner = winner
    @turns = 0
    for x in (0..51)
      @player1.hand.add_card(@deck[x]) if x < 26
      @player2.hand.add_card(@deck[x]) if x > 25
    end
    # You will need to shuffle and pass out the cards to each player
  end

  # You will need to play the entire game in this method using the WarAPI
  def play_game
    begin
      hash = WarAPI.play_turn(@player1, @player1.hand.play_card, @player2, @player2.hand.play_card)
      cards = hash.flatten
      if cards[1].length == 2
        @player1.hand.add_card(cards[1][0])
        @player1.hand.add_card(cards[1][1])
      else
        @player2.hand.add_card(cards[1][0])
        @player2.hand.add_card(cards[1][1])
      end
      puts "#{turns}"
      @turns += 1
    end until (@player1.hand.start == nil || @player2.hand.start == nil)
    if (@player1.hand.start == nil)
      puts "#{@player2.name} wins!"
      @winner = @player2.name
    else
      puts "#{@player1.name} wins!"
      @winner = @player1.name
    end
  end
end


class WarAPI
  # This method will take a card from each player and
  # return a hash with the cards that each player should receive

  def self.play_turn(player1, card1, player2, card2)
    if card1.value > card2.value
      {player1 => [card1, card2], player2 => []}
    elsif card2.value > card1.value || rand(100).even?
      {player1 => [], player2 => [card2, card1]}
    else
      {player1 => [card1, card2], player2 => []}
    end
  end
end
