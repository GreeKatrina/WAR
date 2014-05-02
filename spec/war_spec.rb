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

	it "should take a card and insert it at the front of a player's hand" do
	end

	xit "should be able to remove a card from the end of a player's hand and return it" do
	end
end

describe 'Player' do
	before(:each) do
		@player = Player.new('Katrina')
		@player2 = Player.new('Caresa')
	end

	it "should be able to assign two players a name and give them a hand equal to nil" do
		expect(@player.name).to eq('Katrina')
		expect(@player2.name).to eq('Caresa')
		expect(@player.hand).to eq(nil)
		expect(@player2.hand).to eq(nil)
	end
end

describe 'War' do


	let(:war) { War.new('Katrina', 'Caresa') }

	describe 'initialize' do
		it "should create a new deck and give two players an equal sized hand" do
			expect(war.player1.hand.length).to eq(26)
			expect(war.player2.hand.length).to eq(26)
		end
	end

end