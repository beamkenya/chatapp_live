defmodule ChatAppLive.MessagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ChatAppLive.Messages` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        content: "some content",
        media_link: "some media_link"
      })
      |> ChatAppLive.Messages.create_message()

    message
  end
end
