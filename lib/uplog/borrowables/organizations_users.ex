"""
Author: Arian Allenson Valdez
This is a course requirement for CS 192
Software Engineering II under the
supervision of Asst. Prof. Ma. Rowena C.
Solamo of the Department of Computer
Science, College of Engineering, University
of the Philippines, Diliman for the AY 2019-
2020
"""

defmodule Uplog.Borrowables.OrganizationsUsers do
  use Ecto.Schema
  import Ecto.Changeset

  schema "organizations_users" do
    field :added_by_user_id, :id
    field :type, :id
    belongs_to :user, Uplog.Users.User
    belongs_to :organization, Uplog.Borrowables.Organization

    timestamps()
  end

  @doc false
  def changeset(organizations_users, attrs) do
    organizations_users
    |> cast(attrs, [])
    |> validate_required([])
  end
end
