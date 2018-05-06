require './blackjack.rb'

###################GAME PLAY########################
# allow for multiple rounds
round = 1
while (round > 0)
  puts
  puts "You have sat down at the blackjack table. Would you like to play a round? Y/N"

  yes_no = $stdin.gets.chomp

  # initiate game
  if yes_no.match(/\A(yes|[y])\z/ix)
    player = Player.new
    dealer = Player.new
    puts "The dealer shuffles the cards."
    play_deck = Deck.new
    puts
    puts "He slides a pair of cards towards you."
    puts
    puts player.list_cards
    print "Dealer draws two cards. One of them is "
    print "#{dealer.dealer_hand}."
    puts
    player_hits = 1
    while (player_hits > 0)
      puts "Would you like to hit or keep? H/K"

      hit_keep = $stdin.gets.chomp

      if hit_keep.match(/\A(hit|[h])\z/ix)
        player.hand.hit
        puts player.list_cards
        player_hits += 1
        if player.bust?
          player_hits = 0
          puts "Bust! You lose!"
          return
        end
        if player.blackjack?
          player_hits = 0
          puts "Blackjack, behy-beeee! You win!"
          return
        end
      elsif hit_keep.match(/\A(keep|[k])\z/ix)
        puts "Smart move."
        player_hits = 0
        if player.bust?
          player_hits = 0
        end
        if player.blackjack?
          player_hits = 0
        end
      else
        puts "Say that again?"
        player_hits += 1
      end
      round = 0
    end

    puts "Dealer's turn. He has:"
    puts dealer.list_cards
    dealer.blackjack?
    dealer.bust?
    if dealer.hand_value > player.hand_value && !dealer.hand_value.bust?
      puts "Dealer wins!"
    elsif player.hand_value > dealer.hand_value && !player.hand_value.bust?
      puts "You win!"
    end


  elsif yes_no.match(/\A(no|[n])\z/ix)
    puts "That's too bad. Wimp."

  elsif yes_no == "demo"
    puts "Simulated round, running!"

  else
    puts "Invalid input. I'm calling the bouncer."
    round += 1
  end
end