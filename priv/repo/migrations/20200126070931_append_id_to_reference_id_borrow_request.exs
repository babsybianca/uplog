defmodule Uplog.Repo.Migrations.RenameItemToItemIdBorrowRequest do
  use Ecto.Migration

  def change do
    rename table("borrow_requests"), :item, to: :item_id
    rename table("borrow_requests"), :approved_by, to: :approved_by_id
    rename table("borrow_requests"), :denied_by, to: :denied_by_id
    rename table("borrow_requests"), :received_back_by, to: :received_back_by_id
  end
end
