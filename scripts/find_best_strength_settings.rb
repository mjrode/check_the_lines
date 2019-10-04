require ::File.expand_path('../../config/environment', __FILE__)

results = []
min = 5
max = 8

bet_min = 10
bet_max = bet_min +  (max - min)
iteration_count = 0
iterations_per_cycle = ((max + 1) - min)
iterations = iterations_per_cycle ** 4
time_per_cycle = 1.5
expected_time = (iterations * time_per_cycle)
@best_settings = {win_percent: 0, rlm_strength: 0, line_strength: 0, pub_percentage_strength: 0}

puts "Expected run time: #{expected_time/60} minutes"

start_time = Time.now
(min..max).each do |best_bet|
  $best_bet_strength = best_bet

  (min..max).each do |pub_per|
    $public_percentage_strength = pub_per

    (min..max).each do |rlm_st|
      $rlm_strength = rlm_st

      (min..max).each do |line_str|
        $line_strength = line_str
        iteration_count += 1
        if iteration_count % 5 == 0
          cycles_left = iterations - iteration_count
          puts "#{((cycles_left * time_per_cycle) / 60).round(2)} minutes left"

        end
        Jobs::ProcessAndUpdateGames.run

        results << "=========================RESULTS==================================="
        results << "BEST BET CUTOFF: #{$best_bet_strength} $public_percentage_strength: #{$public_percentage_strength}, $rlm_strength: #{$rlm_strength}, $line_strength: #{$line_strength}"


        win_percent =  (Game.all_correct_spread_best_bets.count.to_f/ Game.all_best_bets.count.to_f).round(2)
        best_bet_count = Game.all_best_bets.count.to_f
        correct_best_bet_count = Game.all_correct_spread_best_bets.count.to_f
        results <<  "\n\nWin percentage #{win_percent}% Correct Best Bets #{correct_best_bet_count} Total Best Bet Count #{best_bet_count}\n\n"
        if win_percent > @best_settings[:win_percent]
          @best_settings = {win_percent: win_percent, rlm_strength: $rlm_strength, line_strength: $line_strength, pub_percentage_strength: $public_percentage_strength}
        end
      end
    end
  end
end
end_time = Time.now
puts results
puts "Best settings found were #{@best_settings}"
puts @best_settings

puts "Script took #{((end_time - start_time) / 60).round(2)} minutes was expected to take #{(expected_time/60).round(2)} minutes"


binding.pry