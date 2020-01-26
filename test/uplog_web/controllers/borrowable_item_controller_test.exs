defmodule UplogWeb.BorrowableItemControllerTest do
  use UplogWeb.ConnCase

  alias Uplog.Borrowables

  @create_attrs %{description: "some description", name: "some name", visible: true}
  @update_attrs %{description: "some updated description", name: "some updated name", visible: false}
  @invalid_attrs %{description: nil, name: nil, visible: nil}

  def fixture(:borrowable_item) do
    {:ok, borrowable_item} = Borrowables.create_borrowable_item(@create_attrs)
    borrowable_item
  end

  describe "index" do
    test "lists all borrowable_items", %{conn: conn} do
      conn = get(conn, Routes.borrowable_item_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Borrowable items"
    end
  end

  describe "new borrowable_item" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.borrowable_item_path(conn, :new))
      assert html_response(conn, 200) =~ "New Borrowable item"
    end
  end

  describe "create borrowable_item" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.borrowable_item_path(conn, :create), borrowable_item: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.borrowable_item_path(conn, :show, id)

      conn = get(conn, Routes.borrowable_item_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Borrowable item"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.borrowable_item_path(conn, :create), borrowable_item: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Borrowable item"
    end
  end

  describe "edit borrowable_item" do
    setup [:create_borrowable_item]

    test "renders form for editing chosen borrowable_item", %{conn: conn, borrowable_item: borrowable_item} do
      conn = get(conn, Routes.borrowable_item_path(conn, :edit, borrowable_item))
      assert html_response(conn, 200) =~ "Edit Borrowable item"
    end
  end

  describe "update borrowable_item" do
    setup [:create_borrowable_item]

    test "redirects when data is valid", %{conn: conn, borrowable_item: borrowable_item} do
      conn = put(conn, Routes.borrowable_item_path(conn, :update, borrowable_item), borrowable_item: @update_attrs)
      assert redirected_to(conn) == Routes.borrowable_item_path(conn, :show, borrowable_item)

      conn = get(conn, Routes.borrowable_item_path(conn, :show, borrowable_item))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, borrowable_item: borrowable_item} do
      conn = put(conn, Routes.borrowable_item_path(conn, :update, borrowable_item), borrowable_item: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Borrowable item"
    end
  end

  describe "delete borrowable_item" do
    setup [:create_borrowable_item]

    test "deletes chosen borrowable_item", %{conn: conn, borrowable_item: borrowable_item} do
      conn = delete(conn, Routes.borrowable_item_path(conn, :delete, borrowable_item))
      assert redirected_to(conn) == Routes.borrowable_item_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.borrowable_item_path(conn, :show, borrowable_item))
      end
    end
  end

  defp create_borrowable_item(_) do
    borrowable_item = fixture(:borrowable_item)
    {:ok, borrowable_item: borrowable_item}
  end
end
