require 'rails_helper'

describe RailwaysController, type: :request do
  before do
    @railway = FactoryBot.create(:railway)
  end

  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do 
      get root_path
      expect(response.status).to eq 200
    end
  end
  describe "GET #show" do
    it "showアクションにリクエストすると正常にレスポンスが返ってくる" do 
      get railway_path(@railway)
      expect(response.status).to eq 200
    end
    it "showアクションにリクエストするとレスポンスに投稿済みの解説のテキストが存在する" do 
      get railway_path(@railway)
      expect(response.body).to include @railway.text
    end
    it "showアクションにリクエストするとレスポンスにコメント一覧表示部分が存在する" do 
      get railway_path(@railway)
      expect(response.body).to include "＜解説＞"
    end
  end 
end