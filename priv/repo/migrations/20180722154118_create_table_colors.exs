defmodule Lego.Repo.Migrations.CreateTableColors do
  use Ecto.Migration
  use Lego.Schema

  def up do
    create table("colors") do
      add(:blue, :integer, null: false)
      add(:green, :integer, null: false)
      add(:is_trans, :boolean, default: false, null: false)
      add(:name, :string, null: false)
      add(:red, :integer, null: false)

      timestamps()
    end
  end

  def down do
    drop(table("colors"))
  end
end
