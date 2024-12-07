defmodule PhoenixGestao.Repo.Migrations.CreateReceitas do
  use Ecto.Migration

  def change do
    create table(:receitas) do
      add :descricao, :string
      add :valor, :decimal
      add :data, :date

      timestamps()
    end
  end
end
