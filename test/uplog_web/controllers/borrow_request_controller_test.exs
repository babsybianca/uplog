defmodule UplogWeb.BorrowRequestControllerTest do
  use UplogWeb.ConnCase

  alias Uplog.Borrowables

  @create_attrs %{approved_at: ~N[2010-04-17 14:00:00], claimed_at: ~N[2010-04-17 14:00:00], received_back_at: ~N[2010-04-17 14:00:00]}
  @update_attrs %{approved_at: ~N[2011-05-18 15:01:01], claimed_at: ~N[2011-05-18 15:01:01], received_back_at: ~N[2011-05-18 15:01:01]}
  @invalid_attrs %{approved_at: nil, claimed_at: nil, received_back_at: nil}

  def fixture(:borrow_request) do
    {:ok, borrow_request} = Borrowables.create_borrow_request(@create_attrs)
    borrow_request
  end

  describe "index" do
    test "lists all borrow_requests", %{conn: conn} do
      conn = get(conn, Routes.borrow_request_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Borrow requests"
    end
  end

  describe "new borrow_request" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.borrow_request_path(conn, :new))
      assert html_response(conn, 200) =~ "New Borrow request"
    end
  end

  describe "create borrow_request" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.borrow_request_path(conn, :create), borrow_request: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.borrow_request_path(conn, :show, id)

      conn = get(conn, Routes.borrow_request_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Borrow request"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.borrow_request_path(conn, :create), borrow_request: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Borrow request"
    end
  end

  describe "edit borrow_request" do
    setup [:create_borrow_request]

    test "renders form for editing chosen borrow_request", %{conn: conn, borrow_request: borrow_request} do
      conn = get(conn, Routes.borrow_request_path(conn, :edit, borrow_request))
      assert html_response(conn, 200) =~ "Edit Borrow request"
    end
  end

  describe "update borrow_request" do
    setup [:create_borrow_request]

    test "redirects when data is valid", %{conn: conn, borrow_request: borrow_request} do
      conn = put(conn, Routes.borrow_request_path(conn, :update, borrow_request), borrow_request: @update_attrs)
      assert redirected_to(conn) == Routes.borrow_request_path(conn, :show, borrow_request)

      conn = get(conn, Routes.borrow_request_path(conn, :show, borrow_request))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, borrow_request: borrow_request} do
      conn = put(conn, Routes.borrow_request_path(conn, :update, borrow_request), borrow_request: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Borrow request"
    end
  end

  describe "delete borrow_request" do
    setup [:create_borrow_request]

    test "deletes chosen borrow_request", %{conn: conn, borrow_request: borrow_request} do
      conn = delete(conn, Routes.borrow_request_path(conn, :delete, borrow_request))
      assert redirected_to(conn) == Routes.borrow_request_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.borrow_request_path(conn, :show, borrow_request))
      end
    end
  end

  defp create_borrow_request(_) do
    borrow_request = fixture(:borrow_request)
    {:ok, borrow_request: borrow_request}
  end
end
