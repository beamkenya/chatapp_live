defmodule ChatAppLive.Repo do
  use Ecto.Repo,
    otp_app: :chat_app_live,
    adapter: Ecto.Adapters.Postgres
end
