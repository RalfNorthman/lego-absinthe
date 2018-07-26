# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Lego.Repo.insert!(%Lego.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule SqlHelper do
  # Postgres does not update auto increment sequence
  # on explicit id inserts. Manual fix for that:
  def set_auto_increment!(table_name) do
    sql = ~s"""
      select setval(
        '#{table_name}_id_seq', 
        (select max(id) from "#{table_name}"))
    """

    Lego.Repo.query!(sql)
  end
end

file_path = File.cwd!() <> "/colors.csv"
Download.from("https://rebrickable.com/media/downloads/colors.csv")

[first | [second | rest]] =
  file_path
  |> Csv.read()
  |> Wrangle.color()

# The first two records had original id values of -1 and 0
first_new_id = Map.update!(first, :id, fn _ -> 1099 end)
second_new_id = Map.update!(second, :id, fn _ -> 1100 end)

[first_new_id | [second_new_id | rest]]
|> Enum.each(&Lego.Repo.insert!/1)

SqlHelper.set_auto_increment!("colors")
