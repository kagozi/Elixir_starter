defmodule PasswordGenerator do
  @moduledoc """
  Documentation for `PasswordGenerator`: Generates random password based on passed params.

  Options example:
    options = %{
      "length" => "5",
      "numbers" => "false",
      "uppercase" => "false",
      "symbols" => "false"
    }
  """


  @allowed_options [:length, :numbers, :uppercase, :symbols]
  @doc """
  Generates passwords for given 

  ## Examples

      iex> PasswordGenerator.hello()
      :world

  """
  # def hello do
  #   :world
  # end

end
