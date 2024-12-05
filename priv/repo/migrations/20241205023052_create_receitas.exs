defmodule PhoenixGestao.Repo.Migrations.CreateReceitas do
  use Ecto.Migration

  def change do
    create table(:receitas) do
      add :descricao, :string
      add :valor, :decimal

      timestamps(type: :utc_datetime)
    end
  end
end
