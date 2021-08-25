defmodule SwcBackendWeb.Resolvers.PostResolvers do
    alias SwcBackend.Articles
    alias SwcBackendWeb.ChangesetErrors

    def list_posts(_, _, _) do
        {:ok, Articles.list_posts}
    end

    def create_post(_,%{input: %{picture: _picture, video: _video} = input}, %{context: %{current_user: user}}) do
        input = compute_input(input, user)
        video_pid = Task.async(fn -> Cloudex.upload(input[:video], %{resource_type: "video"}) end)
        picture_pid = Task.async(fn -> Cloudex.upload(input[:picture]) end)
        
        with {:ok, %{url: video_url}} <- Task.await(video_pid),
             {:ok, %{url: picture_url}} <- Task.await(picture_pid)
        do
            compute_create(%{input | picture: picture_url, video: video_url})
        else
            _ ->
                {:error, message: "Use correct video and image"}
        end
    end

    def create_post(_,%{input: %{picture: _picture} = input}, %{context: %{current_user: user}}) do
        input = compute_input(input, user)
        picture_pid = Task.async(fn -> Cloudex.upload(input[:picture]) end)
        
        with {:ok, %{url: picture_url}} <- Task.await(picture_pid)
        do
            compute_create(%{input | picture: picture_url})
        else
            _ ->
                {:error, message: "Use correct image"}
        end
    end

    def create_post(_,%{input: %{video: _video} = input}, %{context: %{current_user: user}}) do
        input = compute_input(input, user)
        video_pid = Task.async(fn -> Cloudex.upload(input[:video], %{resource_type: "video"}) end)
        
        with {:ok, %{url: video_url}} <- Task.await(video_pid) do
            compute_create(%{input | video: video_url})
        else
            _ ->
                {:error, message: "Use correct video"}
        end
    end

    def create_post(_,%{input: input}, %{context: %{current_user: user}}) do
        input = compute_input(input, user)
        compute_create(input)
    end

    defp compute_input(input, user) do
        Map.merge(input, %{user_id: user.id})
    end

    defp compute_create(input) do
        with {:ok, post} <- Articles.create_post(input)
        do
            subscribe(post)
            {:ok, post}
        else
            {:error, %Ecto.Changeset{} = changeset} ->
                {:error, message: "Post not created, make sure all fields are filled correctly", details: ChangesetErrors.error_details(changeset)}
        end
    end

    defp subscribe(post) do
        Absinthe.Subscription.publish(
            SwcBackendWeb.Endpoint,
            post,
            subscribe_post: :post_add
        )
    end
end