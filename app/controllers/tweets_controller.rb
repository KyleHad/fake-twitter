class TweetsController < ApplicationController
	before_action :get_tweet, :check_auth , only: [:edit, :update, :destroy]

	def get_tweet
		@tweet = Tweet.find(params[:id])
	end

	def check_auth
		if session[:user_id] != @tweet.user_id
		flash[:notice] = "Sorry, you can’t edit this tweet"
		redirect_to tweets_path
		end
	end

	def index
		if params[:zipcode]
			@tweets = Tweet.where(zipcode: params[:zipcode])
		else
			@tweets = Tweet.all
		end
	end

	def show
		@tweet= Tweet.find(params[:id])
	end

	def new
		@tweet= Tweet.new
	end

	def edit
	end

	def create
		@tweet = Tweet.new(tweet_params)
		@tweet.user_id = session[:user_id]
		if @tweet.save!
    	redirect_to root_url, :notice => "Tweeted"
  	else
    	render "new"
  	end
	end

	def update
		@tweet.text = params[:tweet][:text]
		@tweet.save!
		redirect_to @tweet
	end

	def destroy
		@tweet.destroy!
		redirect_to root_url
	end

	def tweet_params
		params.require(:tweet).permit(:text, :user_id)
	end
end
