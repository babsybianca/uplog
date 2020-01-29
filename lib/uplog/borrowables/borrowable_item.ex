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

defmodule Uplog.Borrowables.BorrowableItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "borrowable_items" do
    field :description, :string
    field :name, :string
    field :visible, :boolean, default: true
    has_many :borrow_requests, Uplog.Borrowables.BorrowRequest
    belongs_to :organization, Uplog.Borrowables.Organization

    timestamps()
  end

  @doc false
  def changeset(borrowable_item, attrs) do
    borrowable_item
    |> cast(attrs, [:name, :description, :visible])
    |> validate_required([:name, :description])
  end
end
