# Vim で漢字の再変換

## インストール

```vim
plug ""
```
`:Pluginstall`する。

```vim
vnoremap <silent> <C-k>    :<C-u>Saihenkan ~/Downloads/skk-jisyo/SKK-JISYO.L.txt<CR>
nnoremap <silent> <C-k> viw:<C-u>Saihenkan ~/Downloads/skk-jisyo/SKK-JISYO.L.txt<CR>
vnoremap <silent> k        :<C-u>Saihenkan ~/Downloads/skk-jisyo/SKK-JISYO.itaiji.txt<CR>

```

## 使い方

漢字とふりがなの先頭を選択して、マップしたキーを押すとエコーエリアに選択肢が出るので、アルファベットのキーで選択すると置き換わる。

- 漢字のみのときは選択しなくても２番めの例のキーマップのように記述すれば、カーソル下の単語を選択してから同じように実行される。
- Esc でキャンセル
- 別辞書やワイルドカードで複数辞書の指定もできる。
- 選択候補が多いときは Tab キーで(SKK 辞書上の)見出し語を移れる(一つ見出しを捨てる)
- ふりがな付きからふりがななしへの一発変換はできない(ひらがなに一度直す必要がある)
