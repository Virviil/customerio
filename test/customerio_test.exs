defmodule CustomerioTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    HTTPoison.start
  end

  describe "Customerio::identify" do
    test "Got wrapped responce if success" do
      use_cassette "identify/pass" do
        assert {:ok, %Customerio.Success{}} = Customerio.identify(5, %{email: "test@example.com"})
      end
    end

    test "Got HTTPoison response in response" do
      use_cassette "identify/pass" do
        {:ok, %Customerio.Success{response: response}} = Customerio.identify(5, %{email: "test@example.com"})

        assert %HTTPoison.Response{} = response
        assert 200 = response.status_code
      end
    end

    test "Fail with bad credentials" do
      use_cassette "identify/fail#credentials" do
        {:error, %Customerio.Error{reason: response}} = Customerio.identify(5, %{email: "test@example.com"})

        assert %HTTPoison.Response{} = response
        assert 401 = response.status_code
      end
    end
  end

  describe "Customerio::identify!" do
    test "Got wrapped responce if success" do
      use_cassette "identify/pass" do
        assert %Customerio.Success{} = Customerio.identify!(5, %{email: "test@example.com"})
      end
    end

    test "Got HTTPoison response in response" do
      use_cassette "identify/pass" do
        %Customerio.Success{response: response} = Customerio.identify!(5, %{email: "test@example.com"})

        assert %HTTPoison.Response{} = response
        assert 200 = response.status_code
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
        assert {:ok, %Customerio.Success{}} = Customerio.delete(5)
      end
    end

    test "Got HTTPoison response in response" do
      use_cassette "delete/pass" do
        {:ok, %Customerio.Success{response: response}} = Customerio.delete(5)

        assert %HTTPoison.Response{} = response
        assert 200 = response.status_code
      end
    end

    test "Fail with bad credentials" do
      use_cassette "delete/fail#credentials" do
        {:error, %Customerio.Error{reason: response}} = Customerio.delete(5)

        assert %HTTPoison.Response{} = response
        assert 401 = response.status_code
      end
    end
  end

  describe "Customerio::delete!" do
    test "Got wrapped responce if success" do
      use_cassette "delete/pass" do
        assert %Customerio.Success{} = Customerio.delete!(5)
      end
    end

    test "Got HTTPoison response in response" do
      use_cassette "delete/pass" do
        %Customerio.Success{response: response} = Customerio.delete!(5)

        assert %HTTPoison.Response{} = response
        assert 200 = response.status_code
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
