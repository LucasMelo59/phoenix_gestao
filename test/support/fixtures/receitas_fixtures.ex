defmodule PhoenixGestao.ReceitasFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixGestao.Receitas` context.
  """

  @doc """
  Generate a receita.
  """
  def receita_fixture(attrs \\ %{}) do
    {:ok, receita} =
      attrs
      |> Enum.into(%{
        descricao: "some descricao",
        valor: "120.5"
      })
      |> PhoenixGestao.Receitas.create_receita()

    receita
  end
end
