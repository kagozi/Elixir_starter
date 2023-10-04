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
    length = options["length"] |> String.trim() |> String.to_integer()
    options_without_length = Map.delete(options, "length")
    options_values = Map.values(options_without_length)
    value =
      options_values
      |> Enum.all?(fn x -> String.to_atom(x) |> is_boolean() end)
    validate_options_values_are_boolean(value, length, options_without_length)
  end
  defp validate_options_values_are_boolean(false, _length, _options) do
     {:error, "Only integers allowed for length"}
  end
  defp validate_options_values_are_boolean(true, _length, _options) do
     options = included_options(options)
     invalid_options? = options |> Enum.any?(&(&1 not in @allowed_options))
     validate_options(invalid_options?, length, options)
     strings = included ++ random_strings
     get_result(strings)
  end
  defp get_result(string) do
    string =
      strings
      |> Enum.shuffle()
      |> to_string()
  end
  defp validate_options(false, length, options) do
    generate_strings(length, options)
  end

  defp generate_strings(length, options) do
    options = [:lower_case_letter | options]
    included = include(options)
    length = length - length(included)
    random_strings = generate_random_strings(length, options)
  end

  defp include(options) do
    options
    |> Enum.map(&get(&1))
  end

  defp get(:lowercase_letter) do
    <<Enum.random(?a..?z)>>
  end

  def generate_random_string(length, options) do
    Enum.map(1..length, fn ->
      Enum.random(options) |> get()
    end)
  end

  defp included_options(options) do
    Enum.filter(options, fn { key, value} ->
      value |> String.trim() |> String.to_existing_atom()
    end)
    |> Enum.map(fn {key, _value} -> String.to_atom(key) end)
  end
end
