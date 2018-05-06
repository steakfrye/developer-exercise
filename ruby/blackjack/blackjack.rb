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
    :ace   => 11}

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
      @hand_value += @card.value
    end
    # function to add cards to hand
    def hit
      @card = @deck.deal_card
      @hand_value += @card.value
      @cards.push(@card)
    end
  end
end

# player and dealer will be both considered "Player"
class Player
  attr_accessor :hand, :value, :ace_count

  def initialize
    @hand = Hand.new
    @ace_count = 0
  end

  def list_cards
    @value = @hand.hand_value
    # be sure to iterate through all cards, even after a 'hit'
    for i in (0...@hand.cards.length) do
      @my_card = @hand.cards[i]
      # if an ace is used, keep track of it
      if @my_card.name == :ace
        @ace_count += 1
      end
      # print cards
      print "#{@my_card.name.capitalize} of #{@my_card.suite.capitalize}"
      # add commas to make it look nice
      if i == (@hand.cards.length - 1)
        puts
      else
        print ", "
      end
    end
    puts "Value =\ #{@value}"
  end

  # dealer only shows one card initially
  def dealer_hand
    print "#{@hand.cards[0].name.capitalize} of #{@hand.cards[0].suite.capitalize} worth #{@hand.cards[0].value}"
  end

  # ace value defaults to 11, but in case of bust will drop to 1
  def ace
    while @ace_count > 0 && @hand.hand_value > 21
      @hand.hand_value -= 10
      @ace_count -= 1
      puts "Lowering ace value."
    end
  end

  # bust and blackjack only need to return true or false
  def bust
    if @value > 21
      return true
    end
  end

  def blackjack
    if @value == 21
      return true
    end
  end
end
