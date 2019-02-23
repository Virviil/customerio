defmodule Customerio.DeleteTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "Customerio::delete" do
    test "Got wrapped responce if success" do
      use_cassette "delete/pass" do
        assert {:ok, result} = Customerio.delete(1)
        assert "{}\n" = result
      end
    end

    test "Fail with bad credentials" do
      use_cassette "delete/fail#credentials" do
        {:error, %Customerio.Error{code: code, reason: reason}} = Customerio.delete(1, basic_auth: {"", ""})

        assert 401 = code
        assert reason =~ ~r/Unauthorized request/
      end
    end
  end

  describe "Customerio::delete!" do
    test "Got wrapped responce if success" do
      use_cassette "delete/pass" do
        assert "{}\n" = Customerio.delete!(1)
      end
    end

    test "Fail with bad credentials" do
      use_cassette "delete/fail#credentials" do
        assert_raise Customerio.Error, ~r/Unauthorized request/, fn ->
          Customerio.delete!(1, basic_auth: {"", ""})
        end
      end
    end
  end
end
