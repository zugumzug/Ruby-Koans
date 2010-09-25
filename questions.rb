# ------------------------------------------------------------------

 def test_the_left_most_match_wins
   assert_equal "a", "abbccc az"[/az*/]
 end

 # ------------------------------------------------------------------

# Re-read about_regular_expressions. Muy obfuscato.
# About Constants is confusing, ask about this.
# About Exceptions is confusing. Re-read.

def while_statement
  i = 1
  result = 1
  while i <= 10
    result = result * i
    i += 1
  end
end