"""
Author: Arian Allenson Valdez
This is a course requirement for CS 192
Software Engineering II under the
supervision of Asst. Prof. Ma. Rowena C.
Solamo of the Department of Computer
Science, College of Engineering, University
of the Philippines, Diliman for the AY 2019-
2020
Arian Allenson Valdez - 26/01/2020 - Bootstrap, pass borrowable items
"""

defmodule UplogWeb.PageController do
  use UplogWeb, :controller

  def index(conn, _params) do
    borrowable_items = Uplog.Borrowables.list_borrowable_items()
    render(conn, "index.html", borrowable_items: borrowable_items)
  end
end
