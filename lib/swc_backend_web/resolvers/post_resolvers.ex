defmodule SwcBackendWeb.Resolvers.PostResolvers do
    alias SwcBackend.Articles

    def list_posts(_, _, _) do
        {:ok, Articles.list_posts}
    end

    def create_post(_,%{input: %{picture: _picture, video: _video} = input}, %{context: %{current_user: user}}) do
        input = compute_input(input, user)
        video_pid = Task.async(fn -> Cloudex.upload(input[:video], %{resource_type: "video"}) end)
        picture_pid = Task.async(fn -> Cloudex.upload(input[:picture]) end)
        
        {:ok, %{url: video_url}} = Task.await(video_pid)
        {:ok, %{url: picture_url}} = Task.await(picture_pid)

        # with {:ok, %{url: video_url}} <- Task.await(video_pid),
        #      {:ok, %{url: picture_url}} <- Task.await(picture_pid),
        #      {:ok, post} <- Articles.create_post(%{input | picture: picture_url, video: video_url})
        # do
        #     {:ok, post}
        # else
        #     _ ->
        #         {:error, message: "Post not created, make sure all fields are filled correctly"}
        # end
        compute_create(%{input | picture: picture_url, video: video_url})
    end

    def create_post(_,%{input: %{picture: _picture} = input}, %{context: %{current_user: user}}) do
        input = compute_input(input, user)
        picture_pid = Task.async(fn -> Cloudex.upload(input[:picture]) end)
        
        {:ok, %{url: picture_url}} = Task.await(picture_pid)
        compute_create(%{input | picture: picture_url})

        # with {:ok, %{url: picture_url}} <- Task.await(picture_pid),
        #      {:ok, post} <- Articles.create_post(%{input | picture: picture_url})
        # do
        #     {:ok, post}
        # else
        #     _ ->
        #         {:error, message: "Post not created, make sure all fields are filled correctly"}
        # end
    end

    def create_post(_,%{input: %{video: _video} = input}, %{context: %{current_user: user}}) do
        input = compute_input(input, user)
        video_pid = Task.async(fn -> Cloudex.upload(input[:video], %{resource_type: "video"}) end)
        
        {:ok, %{url: video_url}} = Task.await(video_pid)
        compute_create(%{input | video: video_url})
        # with {:ok, %{url: video_url}} <- Task.await(video_pid),
        #      {:ok, post} <- Articles.create_post(%{input | video: video_url})
        # do
        #     {:ok, post}
        # else
        #     _ ->
        #         {:error, message: "Post not created, make sure all fields are filled correctly"}
        # end
    end

    def create_post(_,%{input: input}, %{context: %{current_user: user}}) do
        input = compute_input(input, user)
        compute_create(input)
        # with {:ok, post} <- Articles.create_post(input)
        # do
        #     {:ok, post}
        # else
        #     _ ->
        #         {:error, message: "Post not created, make sure all fields are filled correctly"}
        # end
    end

    defp compute_input(input, user) do
        Map.merge(input, %{user_id: user.id})
    end

    defp compute_create(input) do
        with {:ok, post} <- Articles.create_post(input)
        do
            {:ok, post}
        else
            _ ->
                {:error, message: "Post not created, make sure all fields are filled correctly"}
        end
    end
end