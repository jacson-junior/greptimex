defmodule Greptimex.ConnectionTest do
  use ExUnit.Case, async: true

  alias Greptimex.Greptime.V1

  test "wraps basic credentials in a protobuf-compatible auth header" do
    header =
      Greptimex.Connection.header(
        catalog: "greptime",
        dbname: "public",
        auth: {:basic, {"greptime", "secret"}}
      )

    assert %V1.AuthHeader{
             auth_scheme: {:basic, %V1.Basic{username: "greptime", password: "secret"}}
           } = header.authorization

    assert is_binary(Protobuf.encode(header))
  end

  test "omits the authorization header when authentication is not configured" do
    header = Greptimex.Connection.header(catalog: "greptime", dbname: "public")

    assert is_nil(header.authorization)
    assert is_binary(Protobuf.encode(header))
  end

  test "wraps a token in a protobuf-compatible auth header" do
    header =
      Greptimex.Connection.header(
        catalog: "greptime",
        dbname: "public",
        auth: {:token, "secret-token"}
      )

    assert %V1.AuthHeader{
             auth_scheme: {:token, %V1.Token{token: "secret-token"}}
           } = header.authorization

    assert is_binary(Protobuf.encode(header))
  end

  test "raises for an unsupported authentication configuration" do
    assert_raise ArgumentError, "unsupported GreptimeDB authentication scheme", fn ->
      Greptimex.Connection.header(
        catalog: "greptime",
        dbname: "public",
        auth: {:unsupported, "secret"}
      )
    end
  end
end
