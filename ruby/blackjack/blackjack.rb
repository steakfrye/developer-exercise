class Card
  attr_accessor :suite, :name, :value

  def initialize(suite, name, value)
    @suite, @name, @value = suite, name, value
  end
end

class Deck
  attr_accessor :playable_cards
  SUITES = [:hearts, :diamonds, :spades, :clubs]
  NAME_VALUES = {
    :two   => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 10,
    :queen => 10,
    :king  => 10,
    :ace   => [11, 1]}

  def initialize
    shuffle
  end

  def deal_card
    random = rand(@playable_cards.size)
    @playable_cards.delete_at(random)
  end

  def shuffle
    @playable_cards = []
    SUITES.each do |suite|
      NAME_VALUES.each do |name, value|
        @playable_cards << Card.new(suite, name, value)
      end
    end
  end
end

class Hand
  attr_accessor :card, :cards, :hand_value

  def initialize
    @cards = []
    @deck = Deck.new
    @hand_value = 0
    # populate cards with 2 cards
    2.times do
      @card = @deck.deal_card
      @cards.push(@card)

      # ace default value is 11. If it automatically 'busts', value is 1
      if @card.name == "ace" && @hand_value >= 10
        @hand_value += @card.value[1].to_i
      elsif @card.name == "ace" && @hand_value <= 10
         @hand_value += @card.value[0].to_i
      else
        @hand_value += @card.value
      end
    end
    def hit
      @hand_value += @card.value
      @cards.push(@card)
    end
  end
end

class Player
  attr_accessor :hand, :hand_value

  def initialize
    @hand = Hand.new
  end

  def list_cards
    # be sure to iterate through all cards, even after a 'hit'
    for i in (0...@hand.cards.length) do
      @my_card = @hand.cards[i]
      print "#{@my_card.name.capitalize} of #{@my_card.suite.capitalize} "
    end
    puts
    puts "Value =\ #{@hand.hand_value}"
  end

  def bust
    if @hand.hand_value > 21
      puts "Bust!"
    end
  end

  def blackjack
    if @hand.hand_value == 21
      puts "Blackjack, bahy-beee!"
    end
  end
end

###################GAME PLAY########################
puts
puts "You have sat down at the blackjack table. Would you like to play a round? Y/N"

yes_no = $stdin.gets.chomp

if yes_no.match(/\A(yes|[y])\z/ix)
  player = Player.new
  dealer = Player.new
  puts "The dealer shuffles the cards."
  play_deck = Deck.new
  puts
  puts "He slides a pair of cards towards you."
  puts
  puts player.list_cards
  puts "Dealer draws two cards. One of them is #{}"
  puts "Would you like to hit or keep? H/K"
  hit_keep = $stdin.gets.chomp

  if hit_keep.match(/\A(hit|[h])\z/ix)
    player.hand.hit
    puts player.list_cards

  elsif hit_keep.match(/\A(keep|[k])\z/ix)
    puts "Smart move."

  else
    puts "Say that again?"
  end

elsif yes_no.match(/\A(no|[n])\z/ix)
  puts "That's too bad. Wimp."

elsif yes_no == "demo"
  puts "Simulated round, running!"

else
  puts "Invalid input. I'm calling the bouncer."
end
