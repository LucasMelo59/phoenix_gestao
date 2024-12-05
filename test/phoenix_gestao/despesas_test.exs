defmodule PhoenixGestao.DespesasTest do
  use PhoenixGestao.DataCase

  alias PhoenixGestao.Despesas

  describe "despesas" do
    alias PhoenixGestao.Despesas.Despesa

    import PhoenixGestao.DespesasFixtures

    @invalid_attrs %{descricao: nil, valor: nil}

    test "list_despesas/0 returns all despesas" do
      despesa = despesa_fixture()
      assert Despesas.list_despesas() == [despesa]
    end

    test "get_despesa!/1 returns the despesa with given id" do
      despesa = despesa_fixture()
      assert Despesas.get_despesa!(despesa.id) == despesa
    end

    test "create_despesa/1 with valid data creates a despesa" do
      valid_attrs = %{descricao: "some descricao", valor: "120.5"}

      assert {:ok, %Despesa{} = despesa} = Despesas.create_despesa(valid_attrs)
      assert despesa.descricao == "some descricao"
      assert despesa.valor == Decimal.new("120.5")
    end

    test "create_despesa/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Despesas.create_despesa(@invalid_attrs)
    end

    test "update_despesa/2 with valid data updates the despesa" do
      despesa = despesa_fixture()
      update_attrs = %{descricao: "some updated descricao", valor: "456.7"}

      assert {:ok, %Despesa{} = despesa} = Despesas.update_despesa(despesa, update_attrs)
      assert despesa.descricao == "some updated descricao"
      assert despesa.valor == Decimal.new("456.7")
    end

    test "update_despesa/2 with invalid data returns error changeset" do
      despesa = despesa_fixture()
      assert {:error, %Ecto.Changeset{}} = Despesas.update_despesa(despesa, @invalid_attrs)
      assert despesa == Despesas.get_despesa!(despesa.id)
    end

    test "delete_despesa/1 deletes the despesa" do
      despesa = despesa_fixture()
      assert {:ok, %Despesa{}} = Despesas.delete_despesa(despesa)
      assert_raise Ecto.NoResultsError, fn -> Despesas.get_despesa!(despesa.id) end
    end

    test "change_despesa/1 returns a despesa changeset" do
      despesa = despesa_fixture()
      assert %Ecto.Changeset{} = Despesas.change_despesa(despesa)
    end
  end
end
