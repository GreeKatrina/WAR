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
		expect(@war.player1.hand.unshuffled_deck.length).to eq(26)
		expect(@war.player2.hand.unshuffled_deck.length).to eq(26)
	end

	it "should take a card and insert it at the front of a player's hand" do
		expect(@war.player1.hand.addhand).to eq([])
		expect{deck.add_card(card).to_not raise_error}
	end

	it "should be able to remove a card from the end of a player's hand and return it" do
		expect(@war.player1.hand.deal_card).to be_instance_of(Card)
		expect(@war.player2.hand.deal_card).to be_instance_of(Card)
	end
end

describe 'Player' do
	before(:each) do
		@player = Player.new('Katrina')
		@player2 = Player.new('Caresa')
	end

	it "should be able to assign two players a name and give them each an empty array" do
		expect(@player.name).to eq('Katrina')
		expect(@player2.name).to eq('Caresa')
		expect(@player.hand.unshuffled_deck).to eq([])
		expect(@player2.hand.unshuffled_deck).to eq([])
	end
end

describe 'War' do

	let(:war) { War.new('Katrina', 'Caresa') }

	describe 'play_game' do
		it 'should see who wins the game' do
			war.play_game
			if war.winner == 'Katrina'
				expect(war.player2.hand.addhand).to eq([])
				(war.player1.hand.addhand.length + war.player1.hand.unshuffled_deck.length).should be >= 52
			else
				expect(war.player1.hand.addhand).to eq([])
				(war.player2.hand.addhand.length + war.player2.hand.unshuffled_deck.length).should be >= 52
			end
		end
	end
end
