defmodule TableauSite.Padder do
  def pad_columns(lists) do
    # Calculate max length for each column position
    max_lengths = get_column_max_lengths(lists)

    # Pad each string in each sublist
    lists
    |> Enum.map(fn sublist ->
      sublist
      |> Enum.zip(max_lengths)
      |> Enum.map(fn {str, max_len} ->
        String.pad_trailing(str, max_len)
      end)
    end)
  end

  defp get_column_max_lengths(lists) do
    lists
    |> Enum.zip()  # Convert list of lists into list of tuples, each containing elements from same position
    |> Enum.map(fn column_tuple ->
      column_tuple
      |> Tuple.to_list()
      |> Enum.map(&String.length/1)
      |> Enum.max()
    end)
  end
end
