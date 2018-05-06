require './blackjack.rb'
##################### B L A C K J A C K ######################
# This is a game of blackjack with one player and one dealer.
# To run automated game, type "demo" when prompted to play.


#######################GAME PLAY#############################

puts "######################################"
puts "You have sat down at the blackjack table. Would you like to play a round? Y/N"

yes_no = $stdin.gets.chomp

# initiate game
if yes_no.match(/\A(yes|[y])\z/ix)
  player = Player.new
  dealer = Player.new
  puts "The dealer shuffles the cards."
  play_deck = Deck.new
  puts "######################################"
  puts "He slides a pair of cards towards you."
  puts
  puts "######################################"
  puts player.list_cards
  player.ace
  puts "######################################"
  print "Dealer draws two cards. One of them is "
  puts "#{dealer.dealer_hand}."
  puts "######################################"
  player_hits = 1
  while (player_hits > 0)
    player.ace
    if player.bust
      player_hits = 0
      puts "Bust! You lose!"
      puts
      puts
      exit
    end
    if player.blackjack
      player_hits = 0
      puts "~~~~~~~Blackjack, behy-beeee! You win!~~~~~~"
      puts
      puts
      exit
    end

    puts "Would you like to hit or keep? H/K"

    hit_keep = $stdin.gets.chomp

    if hit_keep.match(/\A(hit|[h])\z/ix)
      player.hand.hit
      puts player.list_cards
      player_hits += 1


    elsif hit_keep.match(/\A(keep|[k])\z/ix)
      puts "The air is still with suspense."
      puts "......................................"
      puts "......................................"
      player_hits = 0

    else
      puts "Say that again?"
      player_hits += 1
    end
  end

  puts "######################################"
  puts "Dealer has:"
  dealer.ace
  puts dealer.list_cards
  while (dealer.value <= 14)
    puts "######################################"
    puts "Dealer wants to draw."
    dealer.hand.hit
    dealer.ace
    puts dealer.list_cards
    if dealer.bust
      puts "######################################"
      puts"Dealer loses. Which means..."
      puts "~~~~~~You win!~~~~~~"
      puts
      puts
    end
  end
  if (dealer.value >= player.value) && !dealer.bust
    puts "Dealer wins!"
  elsif (player.value > dealer.value) && !player.bust
    puts "~~~~~~You win!~~~~~~"
    puts
    puts
  end


elsif yes_no.match(/\A(no|[n])\z/ix)
  puts "That's too bad. Wimp."

elsif yes_no == "demo"
  puts "Simulated round, running!"
  player = Player.new
  dealer = Player.new
  puts "The dealer shuffles the cards."
  play_deck = Deck.new
  puts "######################################"
  puts "He slides a pair of cards towards the player."
  puts
  puts "######################################"
  puts player.list_cards
  puts "######################################"
  print "Dealer draws two cards. One of them is "
  puts "#{dealer.dealer_hand}."
  puts "######################################"
  player_hits = 1
  while (player_hits > 0)
    player.ace
    if player.bust
      player_hits = 0
      puts "Bust! Player loses!"
      exit
    end
    if player.blackjack
      player_hits = 0
      puts "~~~~~~~Blackjack, behy-beeee! Player wins!~~~~~~"
      exit
    end

    puts "The player is thinking. Will he hit or keep?"
    puts "??????????????????????????????????????"
    puts "######################################"
    if player.value <= 17
      puts "Player hits!"
      player.hand.hit
      puts player.list_cards
      player_hits += 1

    else
      puts "The player wants to keep."
      puts "The air is still with suspense."
      puts "......................................"
      puts "......................................"
      player_hits = 0
    end
  end

  puts "######################################"
  puts "Dealer has:"
  puts dealer.list_cards
  dealer.ace
  while dealer.value <= 14
    puts "######################################"
    puts "Dealer wants to draw."
    dealer.hand.hit
    dealer.ace
    puts dealer.list_cards
    if dealer.bust
      puts "######################################"
      puts"Dealer loses. Which means..."
      puts "~~~~~~Player wins!~~~~~~"
      puts puts
    end
  end
  if (dealer.value >= player.value) && !dealer.bust
    puts "Dealer wins!"
  elsif (player.value > dealer.value) && !player.bust
    puts "~~~~~~Player wins!~~~~~~"
    puts
    puts
  end

else
  puts "Invalid input. I'm calling the bouncer."
end
