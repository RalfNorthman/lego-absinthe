defmodule Lego.Repo.Migrations.CreateTableColors do
  use Ecto.Migration
  use Lego.Schema

  def up do
    create table("colors") do
      add(:blue, :integer)
      add(:green, :integer)
      add(:is_trans, :boolean, default: false)
      add(:name, :string)
      add(:red, :integer)

      timestamps()
    end
  end

  def down do
    drop(table("colors"))
  end
end
