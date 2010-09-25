def score_naive(dice)
  score = 0
  dice = dice.delete_if {|x| 1 > x or x > 6}
  dice = dice.slice(0..4)

  # run through each possible face
  for face in (1..6)
    # see how many times the current face appears in the array
    count = 0
    for die in dice
      count += 1 if die == face
    end

    # now check for triplets
    if count >= 3
      if 1 == face
        score += 1000
      else
        score += 100 * face
      end
      count -= 3
    end

    # now check for the remaining ones
    if count > 0
      if 1 == face
        score += 100 * count
      elsif 5 == face
         score += 50 * count
       end
    end
  end

  score
end

def score_hash(dice)
  score = 0
  dice = dice.delete_if {|x| 1 > x or x > 6}	
  dice = dice.slice(0..4)

  # Use a Hash with a default value of 0 for each new key.
  counts = Hash.new{|h,k| h[k] = 0}

  # Run through each die and increment its count.
  dice.each {|die| counts[die] += 1}

  # Tally up the scores
  counts.each do |k,v|
    score += (k == 1 ? 1000 : (k * 100)) if v >= 3
    if k == 1
      score += 100 * (v % 3)
    elsif k == 5
      score += 50 * (v % 3)
    end
  end
  score
end
