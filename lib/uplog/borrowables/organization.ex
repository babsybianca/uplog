"""
Author: Arian Allenson Valdez
This is a course requirement for CS 192
Software Engineering II under the
supervision of Asst. Prof. Ma. Rowena C.
Solamo of the Department of Computer
Science, College of Engineering, University
of the Philippines, Diliman for the AY 2019-
2020
Arian Allenson Valdez - 26/01/2020 - Scaffold, Add assoc
"""

defmodule Uplog.Borrowables.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  schema "organizations" do
    field :active, :boolean, default: true
    field :description, :string
    field :name, :string
    field :visible, :boolean, default: true
    has_many :borrowable_items, Uplog.Borrowables.BorrowableItem
    many_to_many :users, Uplog.Users.User, join_through: Uplog.Borrowables.OrganizationsUsers

    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:name, :description, :active, :visible])
    |> validate_required([:name, :description, :active, :visible])
  end
end
