require ::File.expand_path('../../config/environment', __FILE__)

results = []
min = 7
max = 8
median = (max - min ) + min
bet_count_change = 0
bet_min = 1
bet_max = bet_min +  (max - min)
bet_median = (bet_max - bet_min ) + bet_min
expected_best_bets = (median / bet_median.to_f) * 480
iteration_count = 0
iterations_per_cycle = ((max + 1) - min)
iterations = iterations_per_cycle ** 4
time_per_cycle = 3.to_f
expected_time = (iterations * time_per_cycle)
@best_settings = {win_percent: 0, rlm_strength: 0, line_strength: 0, pub_percentage_strength: 0}

puts "Expected run time: #{expected_time/60.round(1)} minutes"
puts "Expected average best bets #{expected_best_bets}"
start_time = Time.now
(bet_min..bet_max).each do |best_bet|

  system('clear')
  $best_bet_strength = best_bet

  (min..max).each do |pub_per|

    (min..max).each do |rlm_st|

      (min..max).each do |line_str|
        $rlm_strength = rlm_st
        $public_percentage_strength = pub_per - 1
        $line_strength =  line_str -1
        iteration_count += 1

        cycles_left = iterations - iteration_count
        minutes = ((cycles_left * time_per_cycle) / 60).round(2)
        if minutes > 1
          puts "#{minutes} minutes left"
        else
          puts "#{(minutes * 60).round(0)} seconds left"
        end

        Jobs::ProcessAndUpdateGames.run(process_all_games: true)

        results << "=========================RESULTS==================================="


        win_percent =  (Game.correct_spread_best_bets.count.to_f/ Game.best_bets.count.to_f).round(2)
        best_bet_count = Game.best_bets.count.to_f
        puts "BEST BET CUTOFF: #{$best_bet_strength} $public_percentage_strength: #{$public_percentage_strength}, $rlm_strength: #{$rlm_strength}, $line_strength: #{$line_strength} best bet count #{best_bet_count}"
        results << "BEST BET CUTOFF: #{$best_bet_strength} $public_percentage_strength: #{$public_percentage_strength}, $rlm_strength: #{$rlm_strength}, $line_strength: #{$line_strength}, best bet count #{best_bet_count}"
        correct_best_bet_count = Game.correct_spread_best_bets.count.to_f

        results <<  "\n\nWin percentage #{win_percent}% Correct Best Bets #{correct_best_bet_count} Total Best Bet Count #{best_bet_count}\n\n"

        if win_percent > @best_settings[:win_percent]
          @best_settings = {win_percent: win_percent, rlm_strength: $rlm_strength, line_strength: $line_strength, pub_percentage_strength: $public_percentage_strength, best_bet: best_bet, bet_count: best_bet_count}
        end
        bet_count_change = best_bet_count
        puts "Best bet count ----- #{best_bet_count}"
      end
    end
  end
end


end_time = Time.now

puts results

puts "Best win percentage found was #{@best_settings[:win_percent]}"
puts "Best settings found were RLM: #{@best_settings[:rlm_strength]}, line_strength: #{@best_settings[:line_strength]}, pub percentage #{@best_settings[:pub_percentage_strength]}"
puts @best_settings

puts "Script took #{((end_time - start_time) / 60).round(2)} minutes was expected to take #{(expected_time/60).round(2)} minutes"
