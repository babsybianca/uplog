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

defmodule Uplog.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    pow_user_fields()
    field :super_user, :boolean, default: false
    many_to_many :organizations, Uplog.Borrowables.Organization, join_through: Uplog.Borrowables.OrganizationsUsers

    timestamps()
  end
end
