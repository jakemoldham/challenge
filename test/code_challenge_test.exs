defmodule CodeChallengeTest do
  use ExUnit.Case
  doctest CodeChallenge

  describe "CodeChallenge.answer/1 " do
    test "will pass and return 12 over 1 when pegs are at [4, 30, 50]" do
      assert CodeChallenge.answer([4, 30, 50]) == [12, 1]
    end

    test "will pass and return 8 over 3 when pegs are at [4, 8] " do
      assert CodeChallenge.answer([4, 8]) == [8, 3]
    end

    test "will pass and return 602 over 3 when pegs are at [700, 1001]" do
      assert CodeChallenge.answer([700, 1001]) == [602, 3]
    end

    test "will pass and return 400 over 1 when pegs are at [700, 1000]" do
      assert CodeChallenge.answer([400, 1000]) == [400, 1]
    end

    test " will pass and return 3998 over 3 when pegs are at [1, 2000, 4000, 6000, 8000, 10000]" do
      assert CodeChallenge.answer([1, 2000, 4000, 6000, 8000, 10_000]) == [3998, 3]
    end

    test " will fail and return -1 over -1 when pegs are at [1, 504, 1224]" do
      assert CodeChallenge.answer([1, 504, 1224]) == [-1, -1]
    end
  end
end
