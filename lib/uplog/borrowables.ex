defmodule Uplog.Borrowables do
  @moduledoc """
  The Borrowables context.
  """

  import Ecto.Query, warn: false
  alias Uplog.Repo

  alias Uplog.Borrowables.Organization

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

  alias Uplog.Borrowables.BorrowableItem

  @doc """
  Returns the list of borrowable_items.

  ## Examples

      iex> list_borrowable_items()
      [%BorrowableItem{}, ...]

  """
  def list_borrowable_items do
    Repo.all(BorrowableItem)
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
  def create_borrowable_item(attrs \\ %{}) do
    %BorrowableItem{}
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
    Repo.delete(borrowable_item)
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

  alias Uplog.Borrowables.BorrowRequest

  @doc """
  Returns the list of borrow_requests.

  ## Examples

      iex> list_borrow_requests()
      [%BorrowRequest{}, ...]

  """
  def list_borrow_requests do
    Repo.all(BorrowRequest)
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
  def get_borrow_request!(id), do: Repo.get!(BorrowRequest, id)

  @doc """
  Creates a borrow_request.

  ## Examples

      iex> create_borrow_request(%{field: value})
      {:ok, %BorrowRequest{}}

      iex> create_borrow_request(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_borrow_request(attrs \\ %{}) do
    %BorrowRequest{}
    |> BorrowRequest.changeset(attrs)
    |> Repo.insert()
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
