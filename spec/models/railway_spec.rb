require 'rails_helper'

RSpec.describe Railway, type: :model do
  before do
    @railway = FactoryBot.build(:railway)
    @railway.image = fixture_file_upload('test.png')
  end

  describe '写真の保存' do
    context "写真が保存できる場合" do
      it "画像とテキストがあれば写真は保存される" do
        expect(@railway).to be_valid
      end
    end
    context "写真が保存できない場合" do
      it "テキストがないと写真は保存できない" do
        @railway.text = ""
        @railway.valid?
        expect(@railway.errors.full_messages).to include("Text can't be blank")
      end     
      it "ユーザーが紐付いていないと写真は保存できない" do
        @railway.user = nil
        @railway.valid?
        expect(@railway.errors.full_messages).to include("User must exist")
      end
    end
  end
end