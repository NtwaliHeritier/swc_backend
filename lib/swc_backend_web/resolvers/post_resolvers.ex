defmodule SwcBackendWeb.Resolvers.PostResolvers do
    alias SwcBackend.Articles

    def list_posts(_, _, _) do
        {:ok, Articles.list_posts}
    end

    def create_post(_,%{input: %{picture: _picture, video: _video} = input}, %{context: %{current_user: user}}) do
        input = Map.merge(input, %{user_id: user.id})
        video_pid = Task.async(fn -> Cloudex.upload(input[:video], %{resource_type: "video"}) end)
        picture_pid = Task.async(fn -> Cloudex.upload(input[:picture]) end)
        
        with {:ok, %{url: video_url}} <- Task.await(video_pid),
             {:ok, %{url: picture_url}} <- Task.await(picture_pid),
             {:ok, post} <- Articles.create_post(%{input | picture: picture_url, video: video_url})
        do
            {:ok, post}
        else
            _ ->
                {:error, message: "Post not created, make sure all fields are filled correctly"}
        end
    end

    def create_post(_,%{input: %{picture: _picture} = input}, %{context: %{current_user: user}}) do
        input = Map.merge(input, %{user_id: user.id})
        picture_pid = Task.async(fn -> Cloudex.upload(input[:picture]) end)
        
        with {:ok, %{url: picture_url}} <- Task.await(picture_pid),
             {:ok, post} <- Articles.create_post(%{input | picture: picture_url})
        do
            {:ok, post}
        else
            _ ->
                {:error, message: "Post not created, make sure all fields are filled correctly"}
        end
    end

    def create_post(_,%{input: %{video: _video} = input}, %{context: %{current_user: user}}) do
        input = Map.merge(input, %{user_id: user.id})
        video_pid = Task.async(fn -> Cloudex.upload(input[:video], %{resource_type: "video"}) end)
        
        with {:ok, %{url: video_url}} <- Task.await(video_pid),
             {:ok, post} <- Articles.create_post(%{input | video: video_url})
        do
            {:ok, post}
        else
            _ ->
                {:error, message: "Post not created, make sure all fields are filled correctly"}
        end
    end

    def create_post(_,%{input: input}, %{context: %{current_user: user}}) do
        input = Map.merge(input, %{user_id: user.id})

        with {:ok, post} <- Articles.create_post(input)
        do
            {:ok, post}
        else
            _ ->
                {:error, message: "Post not created, make sure all fields are filled correctly"}
        end
    end
end