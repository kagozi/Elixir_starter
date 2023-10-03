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

    options = %{
      "length" => "5",
      "numbers" => "false",
      "uppercase" => "false",
      symbols => "false"
    }

    iex> PasswordGenerator.generate(options)
    "abcdf"

  """
  @spec generate(options :: map()) :: {:ok, bitstring()} | {:error, bitstring()}
  def generate(options) do
    length = Map.has_key?(options, "length")
    validate_length(length, options)
  end

  defp validate_length(false, _options), do: {:error, "Please provide a length"}

  defp validate_length(true, options) do
    numbers = Enum.map(0..9, & Integer.to_string(&1))
    length = options["length"]
    length = String.contains?(length, numbers)
    validate_length_is_integer(length, options)
  end
  defp validate_length_is_integer(false, _options) do
    {:error, "Only integers allowed for length"}
  end
  defp validate_length_is_integer(true, _options) do
    length = options["length"] | > String.trim() |> String.to_integer()
    options_without_length = Map.delete(options, "length")
    options_values = Map.values(options_without_length)
    value =
      options_values
      |> Enum.all?(fn x -> String.to_atom(x) |> is_boolean())
    validate_options_values_are_boolean(value, length, options_without_length)
  end
  defp validate_options_values_are_boolean(false, _length, _options) do
     {:error, "Only integers allowed for length"}
  end
  defp validate_options_values_are_boolean(true, _length, _options) do
     options = included_options(options)
     
  end
end
