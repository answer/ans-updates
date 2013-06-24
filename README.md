# Ans::Updates

更新情報を表示する

## Installation

Add this line to your application's Gemfile:

    gem 'ans-updates'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ans-updates

## Usage

manage/tops/show で更新情報を表示する場合、以下のようにする

    class Manage::TopsController
      include Ans::Updates
    end
    class Manage::TopsHelper
      include Ans::Updates::Helper
    end

    # tops/show.html.erb
    <div class="page-header">
      <h3>更新情報 <small><%= updates_get_link "更新", class: "btn btn-mini" %></small></h3>
    </div>
    <%= updates_show %>

    # shell
    $ git clone $UPDATES_REPO $RAILS_ROOT/updates

    # asset pipeline に画像を置く場合
    $ cd app/assets/images/manage/; ln -s ../../../../updates/images updates

    # public に画像を置く場合
    $ cd public/manage/images; ln -s ../../updates/images updates

`$UPDATES_REPO` には、更新情報が以下のルールで保存されていること

    $ changelogs/updates-20XX-XX-XX-some_change.md

ファイルには日付が含まれていると仮定して、日付部分を切り出して日付として自動整形する

日付がパースできなければ、日付は自動生成されない

デフォルトでは、 `(\d+-\d+-\d+)` の正規表現にマッチした部分が日付と解釈される

ファイル名は id 属性に使用されるので、わかりやすい名前を使ったほうが良いかも

## オーバーライド可能な設定とデフォルト

    # app/views/ans-updates/show.html.erb
    <section class="well" id="<%= id %>">
      <% if date %><small class="muted pull-right">- <%= updates_date date %> -</small><% end %>
      <%= updates_content content %>
    </section>

    # config/initializers/ans-updates.rb
    Ans::Updates.configure do |config|
      config.path                   = "updates"        # 更新情報リポジトリのパス
      config.changelog_pattern      = "changelogs/*"   # リポジトリ内の更新ログディレクトリのパス
      config.changelog_suffix       = ".md"            # 更新ログの拡張子
      config.changelog_date_pattern = /(\d+-\d+-\d+)/  # 更新ログファイルに含まれる日付のパターン

      config.limit       = 20                        # 更新情報を表示する数
      config.date_format = "%Y/%m/%d"                # 日付のフォーマット
    end

デフォルトのテンプレートは bootstrap 用に作成したもの

この他の設定、ヘルパーメソッドは `lib/ans-updates/helper.rb` を参照

コメント全然書いてないけど頑張って読んでください

## 内部仕様

更新ログを保存する外部リポジトリを配備して、そこから更新情報を読み出す

include したコントローラーに、特定のパラメータに反応して `git pull` する `befire_filter` を追加

別リポジトリにするのは、以下の理由による

1. リポジトリを用意すると、 web 上で編集できる
2. ファイルの更新はコミットになるので、アプリケーションと同一リポジトリだとリリースが必要

bitbucket は、まだファイルの追加はできないみたいだけど待ってればそのうち出来るようになるよ。きっと

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
