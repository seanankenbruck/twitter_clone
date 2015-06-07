class EpicenterController < ApplicationController
  def feed
  	#initialize the array that will hold tweets
  	#from the current_user's following list.
  	@following_tweets = []
  	#pull in all the tweets
  	@tweets = Tweet.all
  	@users = User.all

  	@follower_count = 0
  	#then we sort through the tweets
  	#find the ones associated with users from
  	#current_user's following array
  	if user_signed_in?
	  	@tweets.each do |tweet|
	  		current_user.following.each do |f|
	  			if tweet.user_id == f
	  				@following_tweets.push(tweet)
	  			#those tweets are pushed into the
	  			#array we called in the view
	  			end
	  		end
	  	end
	  	@users.each do |user|
	  		if user.following.include?(current_user.id)
	  			@follower_count += 1
	  		end
	  	end
	else
		redirect_to new_user_session_path
	end
  end

  def show_user
  	@user = User.find(params[:id])
  end

  def now_following
  	@user = User.find(params[:follow_id])
  	current_user.following.push(params[:follow_id].to_i)
  	#adding user.id of the user you want to follow to your 'following' attr
  	current_user.save
  	#then save in database
  	#redirect_to user_profile_path(id: @user.id)
  end

  def unfollow
  	@user = User.find(params[:unfollow_id])
  	current_user.following.delete(params[:unfollow_id].to_i)
  	#removing user.id of the user you want to unfollow from your 'following' attr
  	current_user.save
  	#redirect_to tweets_path
  end
end
