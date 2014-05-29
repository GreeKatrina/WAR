require 'rubygems'
require 'rspec'
require 'pry-debugger'
require_relative '../war.rb'


describe "Card" do
	it "can make a new card" do
		card = Card.new(2, 2, 'Spades')
		expect(card.rank).to eq(2)
		expect(card.value).to eq(2)
		expect(card.suit).to eq('Spades')
	end
end

describe 'Deck' do

	before(:each) do
		@war = War.new("Katrina", "Caresa")
		@deck = Deck.new
		@deck = @deck.make_deck
	end

	it "should be able to create a deck of cards" do
		expect(@deck.length).to eq(52)
	end

	it "should shuffle a deck of cards" do
		deck = Deck.new
		deck = deck.make_deck
		expect(deck).not_to eq(@deck)
	end

	it "should split the deck and give each player a hand" do
		expect(@war.player1.hand.counter).to eq(26)
		expect(@war.player2.hand.counter).to eq(26)
	end

	it "should take a card and insert it at the front of a player's hand" do
		expect(@war.player1.hand.start).to be_a(Node)
		expect(@war.player1.hand.start.card).to be_a(Card)
	end

	it "should be able to remove a card from the end of a player's hand and return it" do
		start = @war.player1.hand.start
		child = start.child
		card = @war.player1.hand.play_card
		expect(start.start).to eq(false)
		expect(child.start).to eq(true)
		expect(card).to be_a(Card)
	end
end

describe 'War' do

	let(:war) { War.new('Katrina', 'Caresa') }

	describe 'play_game' do
		it 'should see who wins the game' do
			war.play_game
			if war.winner == 'Katrina'
				expect(war.player2.hand.counter).to eq(0)
				(war.player1.hand.counter).should be = 52
			else
				expect(war.player1.hand.counter).to eq(0)
				(war.player2.hand.counter).should be = 52
			end
		end
	end
end
