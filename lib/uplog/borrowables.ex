defmodule Uplog.Borrowables do
  @moduledoc """
  The Borrowables context.
  """

  import Ecto, warn: false
  import Ecto.Query, warn: false
  alias Uplog.Repo

  alias Uplog.Users.User
  alias Uplog.Borrowables.OrganizationsUsers
  alias Uplog.Borrowables.Organization
  alias Uplog.Borrowables.BorrowRequest
  alias Uplog.Borrowables.BorrowableItem

  @doc """
  Returns the list of organizations.

  ## Examples

      iex> list_organizations()
      [%Organization{}, ...]

  """
  def list_organizations do
    Repo.all(Organization)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.
  TODO: Should have a bang as it results in an error

  ## Examples

      iex> get_user(123)
      %Organization{}

      iex> get_user(456)
      ** (Ecto.NoResultsError)

  """
  def get_user(id), do: Repo.get!(User, id)

  @doc """
  Gets user's organizations.
  """
  def get_user_organizations(user) do
    user
    |> Ecto.assoc(:organizations)
    |> Repo.all
  end

  @doc """
  Gets a single organization.

  Raises `Ecto.NoResultsError` if the Organization does not exist.

  ## Examples

      iex> get_organization!(123)
      %Organization{}

      iex> get_organization!(456)
      ** (Ecto.NoResultsError)

  """
  def get_organization!(id), do: Repo.get!(Organization, id)

  @doc """
  Gets organization's users.
  """
  def get_organization_users(organization) do
    organization
    |> Ecto.assoc(:users)
    |> Repo.all
  end

  @doc """
  Get users not in organization.
  """
  def get_users_not_in_organization(organization) do
    query = from u in User,
            left_join: o in OrganizationsUsers,
              on: u.id == o.user_id and o.organization_id == ^organization.id,
            where: is_nil(o.organization_id),
            select: u
    Repo.all(query)
  end

  @doc """
  Add organization admin
  """
  def add_organization_admin(organization, user) do
    %OrganizationsUsers{}
    |> OrganizationsUsers.changeset(%{})
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Ecto.Changeset.put_assoc(:organization, organization)
    |> Repo.insert()
  end

  @doc """
  Creates a organization.

  ## Examples

      iex> create_organization(%{field: value})
      {:ok, %Organization{}}

      iex> create_organization(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_organization(attrs \\ %{}) do
    %Organization{}
    |> Organization.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a organization.

  ## Examples

      iex> update_organization(organization, %{field: new_value})
      {:ok, %Organization{}}

      iex> update_organization(organization, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_organization(%Organization{} = organization, attrs) do
    organization
    |> Organization.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a organization.

  ## Examples

      iex> delete_organization(organization)
      {:ok, %Organization{}}

      iex> delete_organization(organization)
      {:error, %Ecto.Changeset{}}

  """
  def delete_organization(%Organization{} = organization) do
    Repo.delete(organization)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking organization changes.

  ## Examples

      iex> change_organization(organization)
      %Ecto.Changeset{source: %Organization{}}

  """
  def change_organization(%Organization{} = organization) do
    Organization.changeset(organization, %{})
  end

  @doc """
  Returns the list of borrowable_items.

  ## Examples

      iex> list_borrowable_items()
      [%BorrowableItem{}, ...]

  """
  def list_borrowable_items do
    from(BorrowableItem, where: [visible: true])
    |> Repo.all
  end

  @doc """
  List borrowable items
  """
  def list_borrowable_items(organization) do
    query = from bi in assoc(organization, :borrowable_items),
      where: bi.visible == true
    Repo.all(query)
  end

  @doc """
  Gets a single borrowable_item.

  Raises `Ecto.NoResultsError` if the Borrowable item does not exist.

  ## Examples

      iex> get_borrowable_item!(123)
      %BorrowableItem{}

      iex> get_borrowable_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_borrowable_item!(id), do: Repo.get!(BorrowableItem, id)

  @doc """
  Creates a borrowable_item.

  ## Examples

      iex> create_borrowable_item(%{field: value})
      {:ok, %BorrowableItem{}}

      iex> create_borrowable_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_borrowable_item(organization, attrs \\ %{}) do
    organization
    |> build_assoc(:borrowable_items)
    |> BorrowableItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a borrowable_item.

  ## Examples

      iex> update_borrowable_item(borrowable_item, %{field: new_value})
      {:ok, %BorrowableItem{}}

      iex> update_borrowable_item(borrowable_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_borrowable_item(%BorrowableItem{} = borrowable_item, attrs) do
    borrowable_item
    |> BorrowableItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a borrowable_item.

  ## Examples

      iex> delete_borrowable_item(borrowable_item)
      {:ok, %BorrowableItem{}}

      iex> delete_borrowable_item(borrowable_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_borrowable_item(%BorrowableItem{} = borrowable_item) do
    borrowable_item
    |> Ecto.Changeset.change(%{})
    |> Ecto.Changeset.put_change(:visible, false)
    |> Repo.update
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking borrowable_item changes.

  ## Examples

      iex> change_borrowable_item(borrowable_item)
      %Ecto.Changeset{source: %BorrowableItem{}}

  """
  def change_borrowable_item(%BorrowableItem{} = borrowable_item) do
    BorrowableItem.changeset(borrowable_item, %{})
  end

  @doc """
  Returns the list of borrow_requests.

  ## Examples

      iex> list_borrow_requests()
      [%BorrowRequest{}, ...]

  """
  def list_borrow_requests(organization_id) do
    query = from br in BorrowRequest,
              left_join: i in BorrowableItem,
                on: br.item_id == i.id,
              where: i.organization_id == ^organization_id and (is_nil(br.approved_at) and is_nil(br.denied_at))
    Repo.all(query)
    |> Repo.preload([:item])
    |> Repo.preload([:borrower_organization])
  end

  @doc """
  Gets a single borrow_request.

  Raises `Ecto.NoResultsError` if the Borrow request does not exist.

  ## Examples

      iex> get_borrow_request!(123)
      %BorrowRequest{}

      iex> get_borrow_request!(456)
      ** (Ecto.NoResultsError)

  """
  def get_borrow_request!(id) do
    Repo.get!(BorrowRequest, id)
    |> Repo.preload([:approved_by])
    |> Repo.preload([:denied_by])
    |> Repo.preload([:item])
    |> Repo.preload([:borrower_organization])
  end

  @doc """
  Returns a result if the user is an organization admin
  """
  def is_user_organization_admin(user, organization) do
    OrganizationsUsers
    |> where([ou], ou.organization_id == ^organization.id)
    |> where([ou], ou.user_id == ^user.id)
    |> Repo.one()
  end

  @doc """
  Approve borrow request
  """
  def approve_borrow_request!(user, id) do
    # TODO:
    # Ensure proper permissions
    # Ensure can approve (has not already denied/approved)
    Repo.get!(BorrowRequest, id)
    |> Repo.preload([:approved_by])
    |> Ecto.Changeset.change(%{})
    |> Ecto.Changeset.put_change(:approved_at, NaiveDateTime.truncate(NaiveDateTime.utc_now, :second))
    |> Ecto.Changeset.put_assoc(:approved_by, user)
    |> Repo.update
  end

  @doc """
  Deny borrow request
  """
  def deny_borrow_request!(user, id) do
    # TODO:
    # Ensure proper permissions
    # Ensure can approve (has not already denied/approved)
    Repo.get!(BorrowRequest, id)
    |> Repo.preload([:denied_by])
    |> Ecto.Changeset.change(%{})
    |> Ecto.Changeset.put_change(:denied_at, NaiveDateTime.truncate(NaiveDateTime.utc_now, :second))
    |> Ecto.Changeset.put_assoc(:denied_by, user)
    |> Repo.update
  end

  @doc """
  Creates a borrow_request.

  ## Examples

      iex> create_borrow_request(%{field: value})
      {:ok, %BorrowRequest{}}

      iex> create_borrow_request(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_borrow_request(user, organization_id, item) do
    # TODO:
    # Check if user has borrow permissions for organization
    # Check if item is borrowable (ie visible)
    
    # Check if item is not currenly being borrowed
    # TODO: Race condition
    br = BorrowRequest
    |> where([br], br.item_id == ^item.id)
    |> where([br], br.borrower_organization_id == ^organization_id)
    |> where([br], is_nil(br.approved_at) and is_nil(br.denied_at))
    |> Repo.exists?()

    if br do
      {:error, %Ecto.Changeset{}}
    else
      %BorrowRequest{}
      |> BorrowRequest.changeset(%{ borrower_organization_id: organization_id })
      |> Ecto.Changeset.put_assoc(:item, item)
      |> Ecto.Changeset.put_assoc(:borrower_user, user)
      |> Repo.insert()
    end
  end

  @doc """
  Updates a borrow_request.

  ## Examples

      iex> update_borrow_request(borrow_request, %{field: new_value})
      {:ok, %BorrowRequest{}}

      iex> update_borrow_request(borrow_request, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_borrow_request(%BorrowRequest{} = borrow_request, attrs) do
    borrow_request
    |> BorrowRequest.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a borrow_request.

  ## Examples

      iex> delete_borrow_request(borrow_request)
      {:ok, %BorrowRequest{}}

      iex> delete_borrow_request(borrow_request)
      {:error, %Ecto.Changeset{}}

  """
  def delete_borrow_request(%BorrowRequest{} = borrow_request) do
    Repo.delete(borrow_request)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking borrow_request changes.

  ## Examples

      iex> change_borrow_request(borrow_request)
      %Ecto.Changeset{source: %BorrowRequest{}}

  """
  def change_borrow_request(%BorrowRequest{} = borrow_request) do
    BorrowRequest.changeset(borrow_request, %{})
  end
end
