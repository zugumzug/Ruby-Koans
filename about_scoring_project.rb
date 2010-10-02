require File.expand_path(File.dirname(__FILE__) + '/edgecase')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#   
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.

def score_by_luke(dice)
  # You need to write this method
  dice = dice.delete_if {|x| 1 > x or x > 6}
  dice = dice.slice!(0..4)

  ones = dice.select {|x| x == 1}
  twos = dice.select {|x| x == 2}
  threes = dice.select {|x| x == 3}
  fours = dice.select {|x| x == 4}
  fives = dice.select {|x| x == 5}
  sixes = dice.select {|x| x == 6}
  
  score = 0

  case ones.length
  when 3 then score += 1000
  when 4 then score += 1100
  when 5 then score += 1200
  else 
    score += ones.length*100
  end
 
  case fives.length
  when 3 then score += 500
  when 4 then score += 550
  when 5 then score += 600
  else 
    score += fives.length*50
  end
=begin #code below does not work, needs to be rewritten with iteration
  everyoneelse = [twos.length, threes.length, fours.length, sixes.length]
  
  case everyoneelse
  when everyoneelse[0] >= 3 then score += 200
  when everyoneelse[1] >= 3 then score += 300
  when everyoneelse[2] >= 3 then score += 400
  when everyoneelse[3] >= 3 then score += 600
  end
=end
  score
end
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

def score(dice)
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

 

class AboutScoringAssignment < EdgeCase::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
  end

end

class ScoringError < StandardError
end
