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

	xit "should take a card and insert it at the front of a player's hand" do
	end

	xit "should be able to remove a card from the end of a player's hand and return it" do
	end
end

describe 'Player' do

	it "should be able to assign two players a name and give them a hand of cards" do
	end
end

describe 'War' do

	it "should be able to "
end