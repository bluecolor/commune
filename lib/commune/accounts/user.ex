defmodule Commune.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :username, :string
    field :email, :string
    field :code, :string
    field :verified, :boolean

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username, :password_hash, :email])
    |> validate_required([:name, :username])
  end

  def activation_changeset(user, attrs) do
    user
    |> cast(attrs, [:verified])
  end

  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:password, :email, :code])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/([\w-\.]+)@((?:[\w]+\.)+)([a-zA-Z]{2,4})/)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
    |> put_verification_code()
    |> put_username()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(pass))
    _->
      changeset
    end
  end

  defp put_verification_code(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true} ->
        put_change(changeset, :code, :crypto.strong_rand_bytes(8) |> Base.encode64 |> binary_part(0, 8))
        |> put_change(:verified, false)
    _->
      changeset
    end
  end

  defp put_username(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true} ->
        put_change(changeset, :username, "User-#{Ecto.UUID.generate()}")
    _->
      changeset
    end
  end

end
