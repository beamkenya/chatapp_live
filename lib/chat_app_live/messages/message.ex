defmodule ChatAppLive.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :content, :string
    field :media_link, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :media_link])
    |> validate_required([:content])
    |> validate_length(:content, max: 150)
  end
end
