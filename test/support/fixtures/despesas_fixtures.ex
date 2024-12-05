defmodule PhoenixGestao.DespesasFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixGestao.Despesas` context.
  """

  @doc """
  Generate a despesa.
  """
  def despesa_fixture(attrs \\ %{}) do
    {:ok, despesa} =
      attrs
      |> Enum.into(%{
        descricao: "some descricao",
        valor: "120.5"
      })
      |> PhoenixGestao.Despesas.create_despesa()

    despesa
  end
end
