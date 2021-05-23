class PostsController < ApplicationController
  before_action :load_filters

  # GET /lists or /lists.json
  def index
    @posts = Post.all
    return unless have_filters?

    filter_date = params[:filters][:date_range]
    filter_networks = params[:filters][:network]
    filter_text = params[:filters][:text]
    @posts = @posts.by_date(filter_date) if filter_date.present?
    @posts = @posts.by_text(filter_text) if filter_text.present?
    @posts = @posts.by_network(filter_networks) if filter_networks.present?
  end

  private

    def have_filters?
      @have_filters ||= 
        params[:filters].present? &&
        (params[:filters][:date_range].present? ||
        params[:filters][:lists].present? ||
        params[:filters][:network].present? ||
        params[:filters][:text].present?)
      
    end

    def load_filters
      @date_range = {
        min: Post.min(:post_date),
        max: Post.max(:post_date) + 1.days
      }
      @lists = List.all
      @networks = SocialMedia.all
    end

    # Only allow a list of trusted parameters through.
    def list_params
      params.require(:filters).permit(
        :date_range,
        :lists,
        :network,
        :text
      )
    end
end
