defmodule Islands.Tally.Tile do
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Island

  @spec new(Island.type() | nil) :: ANSI.ansidata()
  def new(:atoll), do: format(:sandy_brown, "<a>")
  def new(:dot), do: format(:teak, "<d>")
  def new(:l_shape), do: format(:tenne, "<l>")
  def new(:s_shape), do: format(:khaki, "<s>")
  def new(:square), do: format(:chocolate, "<q>")
  def new(:atoll_hit), do: format(:islamic_green, ">a<")
  def new(:dot_hit), do: format(:spring_green, ">d<")
  def new(:l_shape_hit), do: format(:dark_green, ">l<")
  def new(:s_shape_hit), do: format(:pale_green, ">s<")
  def new(:square_hit), do: format(:lawn_green, ">q<")
  def new(:hit), do: format(:islamic_green, ">h<")
  def new(:miss), do: format(:mortar, "<m>")
  def new(:board_miss), do: format(:mortar, "<m>")
  def new(nil), do: format(:dodger_blue, "<o>")

  ## Private functions

  @spec format(atom, String.t()) :: ANSI.ansidata()
  defp format(attr, value),
    do: ANSI.format([attr, :"#{attr}_background", value], true)
end
