require 'rails_helper'

RSpec.describe '切符投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @railway_text = Faker::Lorem.sentence
    @railway_image = fixture_file_upload('test.png')
  end
  context '切符投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのリンクがある
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_railway_path
      # フォームに情報を入力する
      fill_in 'railway_text', with: @railway_text
      # 送信するとTweetモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { Railway.count }.by(1)
      # 投稿完了ページに遷移する
      expect(current_path).to eq railways_path
      # 「投稿が完了しました」の文字がある
      expect(page).to have_content('投稿が完了しました。')
      # トップページに遷移する
      visit root_path
    end
  end
  context '切符投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('投稿する')
    end
  end
end

RSpec.describe '切符編集', type: :system do
  before do
    @railway1 = FactoryBot.create(:railway)
    @railway2 = FactoryBot.create(:railway)
  end
  context '切符編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿した切符の編集ができる' do
      # ツイート1を投稿したユーザーでログインする
      sign_in(@railway1.user)
      # ツイート1に「編集」ボタンがある
       expect(
      all(".more")[1].hover
    ).to have_link '編集', href: edit_railway_path(@railway1)
      # 編集ページへ遷移する
      visit edit_railway_path(@railway1)
      # すでに投稿済みの内容がフォームに入っている
      expect(
        find('#railway_text').value
      ).to eq @railway1.text
      # 投稿内容を編集する
       fill_in 'railway_text', with: "#{@railway1.text}+編集したテキスト"
      # 編集してもTweetモデルのカウントは変わらない
      expect{
        find('input[name="commit"]').click
      }.to change { Railway.count }.by(0)
      # 編集完了画面に遷移する
      expect(current_path).to eq railway_path(@railway1)
      # 「更新が完了しました」の文字がある
      expect(page).to have_content('更新が完了しました。')
      # トップページに遷移する
      visit root_path
    end
  end
  context '切符編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した切符の編集画面には遷移できない' do
      # ツイート1を投稿したユーザーでログインする
      sign_in(@railway1.user)
      # ツイート2に「編集」ボタンがない
      expect(
      all(".more")[0].hover
    ).to have_no_link '編集', href: edit_railway_path(@railway2)
    end
    it 'ログインしていないと切符の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # ツイート1に「編集」ボタンがない
      expect(
      all(".more")[1].hover
    ).to have_no_link '編集', href: edit_railway_path(@railway1)
      # ツイート2に「編集」ボタンがない
      expect(
      all(".more")[0].hover
    ).to have_no_link '編集', href: edit_railway_path(@railway2)
    end
  end
end

RSpec.describe '切符削除', type: :system do
  before do
    @railway1 = FactoryBot.create(:railway)
    @railway2 = FactoryBot.create(:railway)
  end
  context '切符削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿した切符の削除ができる' do
      # ツイート1を投稿したユーザーでログインする
      sign_in(@railway1.user)
      # ツイート1に「削除」ボタンがある
      expect(
        all(".more")[1].hover
      ).to have_link '削除', href: railway_path(@railway1)
      # 投稿を削除するとレコードの数が1減る
      expect{
        all(".more")[1].hover.find_link('削除', href: railway_path(@railway1)).click
      }.to change { Railway.count }.by(-1)
      # 削除完了画面に遷移する
      expect(current_path).to eq railway_path(@railway1)
      # 「削除が完了しました」の文字がある
      expect(page).to have_content('削除が完了しました。')
      # トップページに遷移する
      visit root_path
      # トップページにはツイート1の内容が存在しない（画像）
      expect(page).to have_no_selector ".content_post[style='background-image: url(#{@railway1.image});']"
      # トップページにはツイート1の内容が存在しない（テキスト）
      expect(page).to have_no_content("#{@railway1.text}")
    end
  end
  context '切符削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した切符の削除ができない' do
      # ツイート1を投稿したユーザーでログインする
      sign_in(@railway1.user)
      # ツイート2に「削除」ボタンが無い
      expect(
          all(".more")[0].hover
        ).to have_no_link '削除', href: railway_path(@railway2)
    end
    it 'ログインしていないと切符の削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # ツイート1に「削除」ボタンが無い
       expect(
          all(".more")[1].hover
        ).to have_no_link '削除', href: railway_path(@railway1)
      # ツイート2に「削除」ボタンが無い
       expect(
          all(".more")[0].hover
        ).to have_no_link '削除', href: railway_path(@railway2)
    end
  end
end

RSpec.describe '切符詳細', type: :system do
  before do
    @railway = FactoryBot.create(:railway)
  end
  it 'ログインしたユーザーは切符詳細ページに遷移してコメント投稿欄が表示される' do
    # ログインする
    sign_in(@railway.user)
    # ツイートに「詳細」ボタンがある
    expect(
        all(".more")[0].hover
      ).to have_link '詳細', href: railway_path(@railway)
    # 詳細ページに遷移する
    visit railway_path(@railway)
    # 詳細ページにツイートの内容が含まれている
    expect(page).to have_content("#{@railway.text}")
    # コメント用のフォームが存在する
    expect(page).to have_selector 'form'
  end
  it 'ログインしていない状態で切符詳細ページに遷移できるもののコメント投稿欄が表示されない' do
    # トップページに移動する
    visit root_path
    # ツイートに「詳細」ボタンがある
    expect(
        all(".more")[0].hover
      ).to have_link '詳細', href: railway_path(@railway)
    # 詳細ページに遷移する
    visit railway_path(@railway)
    # 詳細ページにツイートの内容が含まれている
    expect(page).to have_content("#{@railway.text}")
    # フォームが存在しないことを確認する
    expect(page).to have_no_selector 'form'
    # 「コメントの投稿には新規登録/ログインが必要です」が表示されていることを確認する
    expect(page).to have_content '解説の投稿には新規登録/ログインが必要です'
  end
end