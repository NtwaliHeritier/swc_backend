defmodule SwcBackendWeb.Resolvers.PostResolvers do
    alias SwcBackend.Articles

    def list_posts(_, _, _) do
        {:ok, Articles.list_posts}
    end

    def create_post(_,%{input: input},_) do
        video_pid = Task.async(fn -> Cloudex.upload(input.video, %{resource_type: "video"}) end)
        picture_pid = Task.async(fn -> Cloudex.upload(input.picture) end)
        
        with {:ok, %{url: video_url}} <- Task.await(video_pid),
             {:ok, %{url: picture_url}} <- Task.await(picture_pid),
             {:ok, post} <- Articles.create_post(%{input | picture: picture_url, video: video_url})
        do
            {:ok, post}
        else
            _ ->
                {:error, message: "Post not created, make sure all fields are filled correctly"}
        end

        # case Articles.create_post(%{input | picture: picture_url, video: video_url}) do
        #     {:ok, post} ->
        #         {:ok, post}
        #     {:error, %Ecto.Changeset{} = changeset} ->
        #         {:error, message: "Post not created", details: ChangesetErrors.error_details(changeset)}
        # end
    end
end