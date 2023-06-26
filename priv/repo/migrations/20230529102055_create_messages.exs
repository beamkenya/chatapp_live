defmodule ChatAppLive.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :content, :string
      add :media_link, :string

      timestamps()
    end
  end
end
