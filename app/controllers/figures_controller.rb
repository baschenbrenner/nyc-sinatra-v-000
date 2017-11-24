class FiguresController < ApplicationController

  get '/figures' do
    @figures=Figure.all
    erb :"figures/index"
  end

  get '/figures/new' do
    erb :"figures/new"
  end

  get '/figures/:id' do
    @figure= Figure.find(params[:id])
    erb :"/figures/show"
  end

  post '/figures' do

    @figure=Figure.create(name: params["figure"]["name"])
    given_title=params[:figure]["title_ids"]
    given_landmark=params[:figure]["landmark_ids"]
      if given_title != nil
        @figure.titles << Title.find(params[:figure]["title_ids"][0].to_i)
      end
      if given_landmark != nil
        @figure.landmarks << Landmark.find(params[:figure]["landmark_ids"][0].to_i)
      end
      if params[:title]["name"] != ""
        @figure.titles << Title.create(name: params[:title]["name"])
      end
      if params[:landmark]["name"] != ""
        @figure.landmarks << Landmark.create(name: params[:landmark]["name"])
      end

    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure=Figure.find(params[:id])
    erb :"/figures/edit"
  end


  post '/figures/:id' do

    @figure = Figure.find(params[:id])
  
    if params[:figure]["name"] != ""
      @figure.name = params["figure"]["name"]
    end
    if params[:figure]["new_landmark"]["name"] != ""
      @figure.landmarks<<Landmark.create(name: params[:figure]["new_landmark"]["name"])
      if params[:figure]["new_landmark"]["year_completed"] !=""
        Landmark.last.year_completed = params[:figure]["new_landmark"]["year_completed"]
        Landmark.last.save
      end
    end
    if params[:figure]["new_title"]["name"] != ""
      @figure.titles << Title.create(name: params[:figure]["new_title"]["name"])
    end

  @figure.save
  redirect to "/landmarks/#{@landmark.id}"
  end
end
