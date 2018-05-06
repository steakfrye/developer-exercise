require './blackjack.rb'

###################GAME PLAY########################
puts "######################################"
puts "You have sat down at the blackjack table. Would you like to play a round Y/N"

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
  puts "######################################"
  print "Dealer draws two cards. One of them is "
  puts "#{dealer.dealer_hand}."
  puts "######################################"
  player_hits = 1
  while (player_hits > 0)
    if player.bust
      player_hits = 0
      puts "Bust! You lose!"
      break
    end
    if player.blackjack
      player_hits = 0
      puts "~~~~~~~Blackjack, behy-beeee! You win!~~~~~~"
      break
    end

    puts "Would you like to hit or keep H/K"

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
    round = 0
  end

  puts "######################################"
  puts "Dealer has:"
  puts dealer.list_cards
  if dealer.value <= 14
    puts "######################################"
    puts "Dealer wants to draw."
    dealer.hand.hit
    puts dealer.list_cards
    if dealer.bust
      puts "######################################"
      puts"Dealer loses. Which means..."
      puts "~~~~~~You win!~~~~~~"
      puts puts
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

else
  puts "Invalid input. I'm calling the bouncer."
end
