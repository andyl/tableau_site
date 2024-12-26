defmodule Mix.Tasks.Tableau.Site do

  @help """
  Usage: tableau.site <command> | <option>

  Commands:
    list [string]    List all sites, optionally filtered by substring match
    info NAME        Show site info
    url NAME         Get the URL for the specified site
    repo NAME        Get the repository URL for the specified site
    clone NAME DIR   Clone the specified site repository to target directory

  Options:
    -h, --help       Show this help message
    -v, --version    Show the current version

  Examples:
    tableau.site --help
    tableau.site list
    tableau.site list blog
    tableau.site info user/mysite
    tableau.site url user/mysite
    tableau.site repo user/mysite
    tableau.site clone user/mysite ./target_dir
  """

  @moduledoc @help

  @task_version Mix.Project.config()[:version]

  use Mix.Task

  @shortdoc "Find and clone other Tableau websites"

  def run(args) do
    {opts, commands, errors} = OptionParser.parse(args, [
      strict: [
        help: :boolean,
        version: :boolean
      ],
      aliases: [
        h: :help,
        v: :version
      ]
    ])

    case {opts, commands, errors} do
      {[help: true], _, _} -> print_help()
      {[version: true], _, _} -> print_version()
      {_, ["list"], _} -> handle_list()
      {_, ["list", pattern], _} -> handle_list(pattern)
      {_, ["info", site_name], _} -> handle_info(site_name)
      {_, ["url", site_name], _} -> handle_url(site_name)
      {_, ["repo", site_name], _} -> handle_repo(site_name)
      {_, ["clone", site_name, target], _} -> handle_clone(site_name, target)
      {_, [], _} -> print_help()
      {_, [unknown | _], _} -> print_error("Unknown command: #{unknown}")
      {_, _, [{opt, _} | _]} -> print_error("Invalid option: #{opt}")
    end
  end

  defp print_version do
    IO.puts @task_version
  end

  defp print_help do
    IO.puts @help
  end

  defp print_error(message) do
    IO.puts(:stderr, "Error: #{message}")
    System.halt(1)
  end

  defp handle_list do
    IO.puts(TableauSite.table_string())
  end

  defp handle_list(pattern) do
    IO.puts(TableauSite.table_string(pattern))
  end

  defp handle_info(site_name) do
    IO.puts TableauSite.info(site_name)
  end

  defp handle_url(site_name) do
    IO.puts TableauSite.url(site_name)
  end

  defp handle_repo(site_name) do
    IO.puts TableauSite.repo(site_name)
  end

  defp handle_clone(site_name, target) do
    IO.puts "TBD / #{site_name} / #{target}"
  end
end
