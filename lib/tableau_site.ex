defmodule TableauSite do
  @moduledoc """
  Documentation for `TableauSite`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> TableauSite.hello()
      :world

  """
  def hello do
    :world
  end

  @doc """
  Return site data.

  Site data extracted from the [Tableau
  README](https://github.com/elixir-tools/tableau#built-with-tableau).
  """
  def map_data do
    %{
      "elixir-tools/elixir-tools.dev" => %{
        template: "temple",
        styling: "tailwind",
        site_url: "https://www.elixir-tools.dev",
        site_repo: "https://github.com/elixir-tools/elixir-tools.dev",
        description: "Elixir tools site",
        features: "blog, documentation"
      },
      "mhanberg/blog" => %{
        template: "liquid",
        styling: "tailwind",
        site_url: "https://www.mitchellhanberg.com",
        site_repo: "https://github.com/mhanberg/blog",
        description: "Developer site",
        features: "blog"
      },
      "paradox460/pdx.su" => %{
        template: "temple",
        styling: "css",
        site_url: "https://pdx.su",
        site_repo: "https://github.com/paradox460/pdx.su",
        description: "Developer site",
        features: "blog"
      },
      "andyl/xmeyers" => %{
        template: "heex",
        styling: "tailwind",
        site_url: "https://andyl.github.io/xmeyers",
        site_repo: "https://github.com/andyl/xmeyers",
        description: "Information Site"
      },
      "0x7fdev/site" => %{
        template: "heex",
        styling: "magick.css",
        site_url: "https://andyl.github.io/xmeyers",
        site_repo: "https://github.com/0x7fdev/site",
        description: "Information Site"
      },
      "mhanberg/hackery" => %{
        template: "heex",
        styling: "tailwind",
        site_repo: "https://github.com/mhanberg/hackery",
        description: "Tableau Template Site",
        features: "blog, tailwind themes"
      },
    }
  end

  def site_names do
    map_data()
    |> Map.keys()
    |> Enum.sort()
    |> Enum.join(", ")
  end

  def table_headers do
    ~w(Name Template Styling Description)
  end

  def table_data do
    map_data()
    |> Enum.reduce([], &table_row(&1, &2))
    |> Enum.sort()
  end

  def table_data(pattern) do
    down_pattern = String.downcase(pattern)
    Enum.filter(table_data(), fn row ->
      Enum.join(row, " ")
      |> String.downcase()
      |> String.contains?(down_pattern)
    end)
  end

  defp table_row({key, val}, acc) do
    row = [
      key,
      val.template || "",
      val.styling || "",
      val.description || ""
    ]
    acc ++ [row]
  end

  def table_string do
    table_data()
    |> quick_pad()
    |> quick_render()
  end

  def table_string(pattern) do
    pattern
    |> table_data()
    |> quick_pad()
    |> quick_render()
  end

  def quick_render(data) do
    data
    |> Enum.map(fn row -> Enum.join(row, " | ") end)
    |> Enum.join("\n")
  end

  def quick_pad(data) do
    TableauSite.Padder.pad_columns(data)
  end

  def info(name) do
    case Map.get(map_data(), name) do
      nil ->
        "Error: name not found (#{name})\nvalid names: #{site_names()}"
      item ->
        item
        |> Map.merge(%{name: name})
        |> inspect(pretty: true)
        |> IO.puts()
    end
  end

  def url(name) do
    case Map.get(map_data(), name) do
      nil -> "Error: name not found (#{name})\nvalid names: #{site_names()}"
      item -> Map.get(item, :site_url)
    end
  end

  def repo(name) do
    case Map.get(map_data(), name) do
      nil -> "Error: name not found (#{name})\nvalid names: #{site_names()}"
      item -> Map.get(item, :site_repo)
    end
  end

end
