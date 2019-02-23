defmodule Customerio.SegmentsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "Customerio::add_to_segment" do
    test "Got wrapped responce if success" do
      use_cassette "add_to_segment/pass" do
        assert {:ok, result} = Customerio.add_to_segment(1, [1, 2, 3])
        assert "{}\n" = result
      end
    end

    test "Fail with bad credentials" do
      use_cassette "add_to_segment/fail#credentials" do
        {:error, %Customerio.Error{code: code, reason: reason}} =
          Customerio.add_to_segment(1, [1, 2, 3], basic_auth: {"", ""})

        assert 401 = code
        assert reason =~ ~r/Unauthorized request/
      end
    end
  end

  describe "Customerio::add_to_segment!" do
    test "Got wrapped responce if success" do
      use_cassette "add_to_segment/pass" do
        assert "{}\n" = Customerio.add_to_segment!(1, [1, 2, 3])
      end
    end

    test "Fail with bad credentials" do
      use_cassette "add_to_segment/fail#credentials" do
        assert_raise Customerio.Error, ~r/Unauthorized request/, fn ->
          Customerio.add_to_segment!(1, [1, 2, 3], basic_auth: {"", ""})
        end
      end
    end
  end





  describe "Customerio::remove_from_segment" do
    test "Got wrapped responce if success" do
      use_cassette "remove_from_segment/pass" do
        assert {:ok, result} = Customerio.remove_from_segment(1, [1, 2, 3])
        assert "{}\n" = result
      end
    end

    test "Fail with bad credentials" do
      use_cassette "remove_from_segment/fail#credentials" do
        {:error, %Customerio.Error{code: code, reason: reason}} =
          Customerio.remove_from_segment(1, [1, 2, 3], basic_auth: {"", ""})

        assert 401 = code
        assert reason =~ ~r/Unauthorized request/
      end
    end
  end

  describe "Customerio::remove_from_segment!" do
    test "Got wrapped responce if success" do
      use_cassette "remove_from_segment/pass" do
        assert "{}\n" = Customerio.remove_from_segment!(1, [1, 2, 3])
      end
    end

    test "Fail with bad credentials" do
      use_cassette "remove_from_segment/fail#credentials" do
        assert_raise Customerio.Error, ~r/Unauthorized request/, fn ->
          Customerio.remove_from_segment!(1, [1, 2, 3], basic_auth: {"", ""})
        end
      end
    end
  end
end
