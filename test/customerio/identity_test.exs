defmodule Customerio.IdentityTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "Customerio::identify" do
    test "Got responce if success" do
      ExVCR.Config.filter_request_options("basic_auth")
      use_cassette "identify/pass" do
        assert {:ok, result} = Customerio.identify(1, %{email: "test@example.com"})
        assert "{}\n" == result
      end
    end

    test "Fail with bad credentials" do
      use_cassette "identify/fail#credentials" do
        {:error, %Customerio.Error{reason: reason, code: code}} = Customerio.identify(1, %{email: "test@example.com"}, basic_auth: {"", ""})

        assert reason =~ ~r/Unauthorized request/
        assert 401 = code
      end
    end
  end

  describe "Customerio::identify!" do
    test "Got wrapped responce if success" do
      use_cassette "identify/pass" do
        assert "{}\n" = Customerio.identify!(1, %{email: "test@example.com"})
      end
    end

    test "Fail with bad credentials" do
      use_cassette "identify/fail#credentials" do
        assert_raise Customerio.Error, ~r/Unauthorized request/, fn ->
          Customerio.identify!(1, %{email: "test@example.com"}, basic_auth: {"", ""})
        end
      end
    end
  end
end
