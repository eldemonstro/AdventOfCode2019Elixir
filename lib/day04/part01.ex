contents = 168_630..718_098

IO.puts contents
|>Enum.filter(fn pass ->
  never_decrease = pass
                   |>Integer.digits()
                   |>Enum.reduce([true, 0], fn digit, check ->
                     [decrease | [last | _]] = check
                     [decrease && digit >= last, digit]
                   end)
                   |>Enum.at(0)


  same_digits = pass
                |>Integer.digits()
                |>Enum.uniq()

  never_decrease && (length(same_digits) != length(Integer.digits(pass)))
end)
|>length
