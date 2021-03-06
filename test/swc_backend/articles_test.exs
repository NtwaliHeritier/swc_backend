defmodule SwcBackend.ArticlesTest do
  use SwcBackend.DataCase

  alias SwcBackend.Articles

  describe "posts" do
    alias SwcBackend.Articles.Post

    @valid_attrs %{picture: "some picture", text: "some text", video: "some video"}
    @update_attrs %{picture: "some updated picture", text: "some updated text", video: "some updated video"}
    @invalid_attrs %{picture: nil, text: nil, video: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Articles.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Articles.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Articles.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Articles.create_post(@valid_attrs)
      assert post.picture == "some picture"
      assert post.text == "some text"
      assert post.video == "some video"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Articles.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Articles.update_post(post, @update_attrs)
      assert post.picture == "some updated picture"
      assert post.text == "some updated text"
      assert post.video == "some updated video"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Articles.update_post(post, @invalid_attrs)
      assert post == Articles.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Articles.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Articles.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Articles.change_post(post)
    end
  end

  describe "comments" do
    alias SwcBackend.Articles.Comment

    @valid_attrs %{text: "some text"}
    @update_attrs %{text: "some updated text"}
    @invalid_attrs %{text: nil}

    def comment_fixture(attrs \\ %{}) do
      {:ok, comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Articles.create_comment()

      comment
    end

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Articles.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Articles.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      assert {:ok, %Comment{} = comment} = Articles.create_comment(@valid_attrs)
      assert comment.text == "some text"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Articles.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{} = comment} = Articles.update_comment(comment, @update_attrs)
      assert comment.text == "some updated text"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Articles.update_comment(comment, @invalid_attrs)
      assert comment == Articles.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Articles.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Articles.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Articles.change_comment(comment)
    end
  end
end
