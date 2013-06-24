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

    # tops/show.html.erb
    <%= show_updates %>

    # shell
    $ git clone $UPDATES_REPO app/views/manage/tops/updates

`$UPDATES_REPO` には、更新情報が以下のルールで保存されていること

    $ changelog/update-20XX-XX-XX.md

ファイルには日付が含まれていると仮定して、日付部分を切り出して日付として自動整形する

日付がパースできなければ、日付は自動生成されない

## オーバーライド可能な設定とデフォルト

    # app/views/manage/tops/ans-updates/show.html.erb
    <small class="muted">- <%= date %> -</small>
    <%= raw Redcarpet.new(content).to_html %>

デフォルトのテンプレートは bootstrap 用に作成したもの

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
