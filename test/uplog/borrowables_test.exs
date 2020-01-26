defmodule Uplog.BorrowablesTest do
  use Uplog.DataCase

  alias Uplog.Borrowables

  describe "organizations" do
    alias Uplog.Borrowables.Organization

    @valid_attrs %{active: true, description: "some description", name: "some name", visible: true}
    @update_attrs %{active: false, description: "some updated description", name: "some updated name", visible: false}
    @invalid_attrs %{active: nil, description: nil, name: nil, visible: nil}

    def organization_fixture(attrs \\ %{}) do
      {:ok, organization} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Borrowables.create_organization()

      organization
    end

    test "list_organizations/0 returns all organizations" do
      organization = organization_fixture()
      assert Borrowables.list_organizations() == [organization]
    end

    test "get_organization!/1 returns the organization with given id" do
      organization = organization_fixture()
      assert Borrowables.get_organization!(organization.id) == organization
    end

    test "create_organization/1 with valid data creates a organization" do
      assert {:ok, %Organization{} = organization} = Borrowables.create_organization(@valid_attrs)
      assert organization.active == true
      assert organization.description == "some description"
      assert organization.name == "some name"
      assert organization.visible == true
    end

    test "create_organization/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Borrowables.create_organization(@invalid_attrs)
    end

    test "update_organization/2 with valid data updates the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{} = organization} = Borrowables.update_organization(organization, @update_attrs)
      assert organization.active == false
      assert organization.description == "some updated description"
      assert organization.name == "some updated name"
      assert organization.visible == false
    end

    test "update_organization/2 with invalid data returns error changeset" do
      organization = organization_fixture()
      assert {:error, %Ecto.Changeset{}} = Borrowables.update_organization(organization, @invalid_attrs)
      assert organization == Borrowables.get_organization!(organization.id)
    end

    test "delete_organization/1 deletes the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{}} = Borrowables.delete_organization(organization)
      assert_raise Ecto.NoResultsError, fn -> Borrowables.get_organization!(organization.id) end
    end

    test "change_organization/1 returns a organization changeset" do
      organization = organization_fixture()
      assert %Ecto.Changeset{} = Borrowables.change_organization(organization)
    end
  end

  describe "borrowable_items" do
    alias Uplog.Borrowables.BorrowableItem

    @valid_attrs %{description: "some description", name: "some name", visible: true}
    @update_attrs %{description: "some updated description", name: "some updated name", visible: false}
    @invalid_attrs %{description: nil, name: nil, visible: nil}

    def borrowable_item_fixture(attrs \\ %{}) do
      {:ok, borrowable_item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Borrowables.create_borrowable_item()

      borrowable_item
    end

    test "list_borrowable_items/0 returns all borrowable_items" do
      borrowable_item = borrowable_item_fixture()
      assert Borrowables.list_borrowable_items() == [borrowable_item]
    end

    test "get_borrowable_item!/1 returns the borrowable_item with given id" do
      borrowable_item = borrowable_item_fixture()
      assert Borrowables.get_borrowable_item!(borrowable_item.id) == borrowable_item
    end

    test "create_borrowable_item/1 with valid data creates a borrowable_item" do
      assert {:ok, %BorrowableItem{} = borrowable_item} = Borrowables.create_borrowable_item(@valid_attrs)
      assert borrowable_item.description == "some description"
      assert borrowable_item.name == "some name"
      assert borrowable_item.visible == true
    end

    test "create_borrowable_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Borrowables.create_borrowable_item(@invalid_attrs)
    end

    test "update_borrowable_item/2 with valid data updates the borrowable_item" do
      borrowable_item = borrowable_item_fixture()
      assert {:ok, %BorrowableItem{} = borrowable_item} = Borrowables.update_borrowable_item(borrowable_item, @update_attrs)
      assert borrowable_item.description == "some updated description"
      assert borrowable_item.name == "some updated name"
      assert borrowable_item.visible == false
    end

    test "update_borrowable_item/2 with invalid data returns error changeset" do
      borrowable_item = borrowable_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Borrowables.update_borrowable_item(borrowable_item, @invalid_attrs)
      assert borrowable_item == Borrowables.get_borrowable_item!(borrowable_item.id)
    end

    test "delete_borrowable_item/1 deletes the borrowable_item" do
      borrowable_item = borrowable_item_fixture()
      assert {:ok, %BorrowableItem{}} = Borrowables.delete_borrowable_item(borrowable_item)
      assert_raise Ecto.NoResultsError, fn -> Borrowables.get_borrowable_item!(borrowable_item.id) end
    end

    test "change_borrowable_item/1 returns a borrowable_item changeset" do
      borrowable_item = borrowable_item_fixture()
      assert %Ecto.Changeset{} = Borrowables.change_borrowable_item(borrowable_item)
    end
  end

  describe "borrow_requests" do
    alias Uplog.Borrowables.BorrowRequest

    @valid_attrs %{approved_at: ~N[2010-04-17 14:00:00], claimed_at: ~N[2010-04-17 14:00:00], received_back_at: ~N[2010-04-17 14:00:00]}
    @update_attrs %{approved_at: ~N[2011-05-18 15:01:01], claimed_at: ~N[2011-05-18 15:01:01], received_back_at: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{approved_at: nil, claimed_at: nil, received_back_at: nil}

    def borrow_request_fixture(attrs \\ %{}) do
      {:ok, borrow_request} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Borrowables.create_borrow_request()

      borrow_request
    end

    test "list_borrow_requests/0 returns all borrow_requests" do
      borrow_request = borrow_request_fixture()
      assert Borrowables.list_borrow_requests() == [borrow_request]
    end

    test "get_borrow_request!/1 returns the borrow_request with given id" do
      borrow_request = borrow_request_fixture()
      assert Borrowables.get_borrow_request!(borrow_request.id) == borrow_request
    end

    test "create_borrow_request/1 with valid data creates a borrow_request" do
      assert {:ok, %BorrowRequest{} = borrow_request} = Borrowables.create_borrow_request(@valid_attrs)
      assert borrow_request.approved_at == ~N[2010-04-17 14:00:00]
      assert borrow_request.claimed_at == ~N[2010-04-17 14:00:00]
      assert borrow_request.received_back_at == ~N[2010-04-17 14:00:00]
    end

    test "create_borrow_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Borrowables.create_borrow_request(@invalid_attrs)
    end

    test "update_borrow_request/2 with valid data updates the borrow_request" do
      borrow_request = borrow_request_fixture()
      assert {:ok, %BorrowRequest{} = borrow_request} = Borrowables.update_borrow_request(borrow_request, @update_attrs)
      assert borrow_request.approved_at == ~N[2011-05-18 15:01:01]
      assert borrow_request.claimed_at == ~N[2011-05-18 15:01:01]
      assert borrow_request.received_back_at == ~N[2011-05-18 15:01:01]
    end

    test "update_borrow_request/2 with invalid data returns error changeset" do
      borrow_request = borrow_request_fixture()
      assert {:error, %Ecto.Changeset{}} = Borrowables.update_borrow_request(borrow_request, @invalid_attrs)
      assert borrow_request == Borrowables.get_borrow_request!(borrow_request.id)
    end

    test "delete_borrow_request/1 deletes the borrow_request" do
      borrow_request = borrow_request_fixture()
      assert {:ok, %BorrowRequest{}} = Borrowables.delete_borrow_request(borrow_request)
      assert_raise Ecto.NoResultsError, fn -> Borrowables.get_borrow_request!(borrow_request.id) end
    end

    test "change_borrow_request/1 returns a borrow_request changeset" do
      borrow_request = borrow_request_fixture()
      assert %Ecto.Changeset{} = Borrowables.change_borrow_request(borrow_request)
    end
  end
end
