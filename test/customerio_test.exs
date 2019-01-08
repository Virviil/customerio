defmodule CustomerioTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "Customerio::identify" do
    test "Got responce if success" do
      use_cassette "identify/pass" do
        assert {:ok, result} = Customerio.identify(5, %{email: "test@example.com"})
        assert "{}\n" == result
      end
    end

    test "Fail with bad credentials" do
      use_cassette "identify/fail#credentials" do
        {:error, %Customerio.Error{reason: reason, code: code}} = Customerio.identify(5, %{email: "test@example.com"})

        assert reason =~ ~r/Unauthorized request/
        assert 401 = code
      end
    end
  end

  describe "Customerio::identify!" do
    test "Got wrapped responce if success" do
      use_cassette "identify/pass" do
        assert "{}\n" = Customerio.identify!(5, %{email: "test@example.com"})
      end
    end

    test "Fail with bad credentials" do
      use_cassette "identify/fail#credentials" do
        assert_raise Customerio.Error, ~r/Unauthorized request/, fn ->
          Customerio.identify!(5, %{email: "test@example.com"})
        end
      end
    end
  end

  describe "Customerio::delete" do
    test "Got wrapped responce if success" do
      use_cassette "delete/pass" do
        assert {:ok, result} = Customerio.delete(5)
        assert "{}\n" = result
      end
    end

    test "Fail with bad credentials" do
      use_cassette "delete/fail#credentials" do
        {:error, %Customerio.Error{code: code, reason: reason}} = Customerio.delete(5)

        assert 401 = code
        assert reason =~ ~r/Unauthorized request/
      end
    end
  end

  describe "Customerio::delete!" do
    test "Got wrapped responce if success" do
      use_cassette "delete/pass" do
        assert "{}\n" = Customerio.delete!(5)
      end
    end

    test "Fail with bad credentials" do
      use_cassette "delete/fail#credentials" do
        assert_raise Customerio.Error, ~r/Unauthorized request/, fn ->
          Customerio.delete!(5)
        end
      end
    end
  end
end
