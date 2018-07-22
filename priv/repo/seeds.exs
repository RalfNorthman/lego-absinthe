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

file_path = File.cwd!() <> "/colors.csv"
Download.from("https://rebrickable.com/media/downloads/colors.csv")

[first | [second | rest]] =
  file_path
  |> Csv.read()
  |> Wrangle.color()

first_new_id = Map.update!(first, :id, fn _ -> 1099 end)
second_new_id = Map.update!(second, :id, fn _ -> 1100 end)

[first_new_id | [second_new_id | rest]]
|> Enum.each(&Lego.Repo.insert!/1)
