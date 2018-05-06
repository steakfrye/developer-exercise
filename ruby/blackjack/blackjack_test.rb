require './blackjack.rb'
require 'test/unit'

class AceTest < Test::Unit::TestCase
  def setup
    @card = Card.new(:hearts, :ace, [11, 1])
    @player = Player.new
  end

  def test_ace_value_is_correct_if_automatic_bust
    @player.hand.cards = [@card, [:spades, :ten, 10]]
    @my_card = @player.hand.cards[0]
    assert_equal @my_card.value, 1
  end

  def test_ace_value_is_correct_is_11_by_default
    @player.hand.cards = [@card, [:spades, :one, 10]]
    @my_card = @player.hand.cards[0]
    assert_equal @my_card.value, 11
  end
end

class CardTest < Test::Unit::TestCase
  def setup
    @card = Card.new(:hearts, :ten, 10)
  end

  def test_card_suite_is_correct
    assert_equal @card.suite, :hearts
  end

  def test_card_name_is_correct
    assert_equal @card.name, :ten
  end
  def test_card_value_is_correct
    assert_equal @card.value, 10
  end
end

class DeckTest < Test::Unit::TestCase
  def setup
    @deck = Deck.new
  end

  def test_new_deck_has_52_playable_cards
    assert_equal @deck.playable_cards.size, 52
  end

  def test_dealt_card_should_not_be_included_in_playable_cards
    card = @deck.deal_card
    assert !(@deck.playable_cards.include?(card))
  end

  def test_shuffled_deck_has_52_playable_cards
    @deck.shuffle
    assert_equal @deck.playable_cards.size, 52
  end
end
