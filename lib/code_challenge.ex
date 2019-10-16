defmodule CodeChallenge do
  @moduledoc """
  Service for pegs code challenge
  """

  ####
  ## PUBLIC
  ####

  @doc """
  #iex> CodeChallenge.call || #iex> CodeChallenge.call(pegs)

  CodeChallenge.call to kick off service to enter command line pegs
  """
  def call do
    IO.puts("Lets start adding some pegs! Please add more than 1 and less than 20.")

    call([])
  end

  def call(pegs) do
    case get_pegs() do
      0 ->
        run_answer(pegs)

      peg when peg < 1 ->
        IO.puts("Pegs can not be less than 1 you sneak.")
        call(pegs)

      peg when peg > 10_000 ->
        IO.puts("Pegs can not be larger than 10_000 🤯.")
        call(pegs)

      _ when length(pegs) > 20 ->
        IO.puts(
          "The list of Pegs according to the challenge should not exceed 20, running list with 20 pegs."
        )

        run_answer(pegs)

      peg ->
        call([peg | pegs])
    end
  end

  @doc """
  CodeChallenge.answer(pegs)

  ## Examples

  #iex> CodeChallenge.answer(pegs)
  #[numerator, denominator]

  """
  def answer(pegs) when length(pegs) == 1, do: [-1, -1]

  def answer(pegs) when rem(length(pegs), 2) == 0 do
    last_peg = Enum.at(pegs, -1)

    sum = find_sum(pegs)

    first_radius = (sum - last_peg) / 3 * 2

    case iterate_pegs(first_radius, pegs) do
      true ->
        if rem((Kernel.trunc(sum) - last_peg) * 2, 3) > 0 do
          [(Kernel.trunc(sum) - last_peg) * 2, 3]
        else
          Tuple.to_list(Float.ratio((sum - last_peg) / 3 * 2))
        end

      _ ->
        [-1, -1]
    end
  end

  def answer(pegs) do
    last_peg = Enum.at(pegs, -1)

    sum = find_sum(pegs)

    first_radius = (sum + last_peg) * 2

    case iterate_pegs(first_radius, pegs) do
      true ->
        Tuple.to_list(Float.ratio(first_radius))
      _ ->
        [-1, -1]
    end
  end

  ####
  ## PRIVATE
  ####

  defp find_sum(pegs) do
    pegs
    |> Enum.with_index()
    |> Enum.reduce(0, fn {peg, index}, acc ->
      acc + if index == 0, do: -peg, else: 2 * :math.pow(-1, index + 1) * peg
    end)
  end

  defp get_pegs do
    "Please add a peg between 1 and 10_000: \n"
    |> IO.gets()
    |> String.trim()
    |> String.to_integer()
  end

  defp iterate_pegs(_current_radius, pegs) when length(pegs) == 1, do: true

  defp iterate_pegs(current_radius, [head | tail]) do
    difference_between = Enum.at(tail, 0) - head
    next_radius = difference_between - current_radius
    if current_radius < 1 || next_radius < 1, do: false, else: iterate_pegs(next_radius, tail)
  end

  defp run_answer(pegs) do
    pegs
    |> Enum.uniq()
    |> Enum.sort()
    |> answer()
  end
end
