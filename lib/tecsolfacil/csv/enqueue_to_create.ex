defmodule Tecsolfacil.Csv.EnqueueToCreate do
  @moduledoc """
  Create a Oban job and enqueues to the worker who will generate
  the .csv file

  The reason for the "unique: [period: 1]" is that the names changes
  per second, if more than one job is enqueued in less than one second
  we could get in trouble.

  The reason that I create the gen_file_name/0 function is that
  a unique name is needed, then problems like rewriting files
  are evaded.
  """

  alias TecsolfacilWorkers.CreateCsvFromAddress

  def call, do: enqueue(gen_file_name())

  defp enqueue(file_name) do
    %{file_name: file_name}
    |> CreateCsvFromAddress.new(unique: [period: 1])
    |> Oban.insert()
  end

  def gen_file_name do
    NaiveDateTime.local_now()
    |> NaiveDateTime.to_string()
    |> String.replace(~r/[^\d]/, "")
  end
end
