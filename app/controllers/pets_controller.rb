class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    #binding.pry
    @pet = Pet.create(params[:pet])
    if !params[:owner_name].empty?
      @owner = Owner.create(name: params[:owner_name])
      @pet[:owner_id] = @owner.id
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    #binding.pry
    @pet = Pet.find_by_id(params[:id])
    erb :'/pets/edit'
  end


  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    binding.pry
    @pet = Pet.find_by_id(params[:id])
    @pet.update(name: params["pet_name"])

    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params[:owner_name])
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end

    redirect to "pets/#{@pet.id}"
  end
end
