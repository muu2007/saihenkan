scriptencoding utf-8
if !exists('g:loaded_saihenkan')
    finish
endif
let g:loaded_saihenkan = 1
let s:save_cpo = &cpo
set cpo&vim

function! saihenkan#Saihenkan(offset, skk_jisyo) abort " 再変換:候補を示して置き換える 異体字辞書でも可
  silent normal! gv"yy
  let indexes = 'asdfghjklqwertyuiopzxcvbnmASDFGHJKLQWERTYUIOPZXCVBNM1234567890'  " 標識分のみ候補になる
  let tails = 'あaいiうuえeおoかkきkくkけkこkさsしsすsせsそsたtちtつtてtとtなnにnぬnねnのnはhひhふhへhほhまmみmむmめmもmやyゆyよyらrりrるrれrろrわwをwんnがgぎgぐgげgごgざzじzずzぜzぞzだdぢdづdでdどdばbびbぶbべbぼbっt'  " 1ペアのみ使われる
  let entries = system('sel=$(printf "%q" "'.@y.'" |nkf --hiragana) ;tail=$(echo "'.tails.'" |grep -o "${sel: -1}[a-z]");(grep -Eih "^${sel}\s" '.a:skk_jisyo.' |sed -r "s@(\s|;[^/]+)?/@/@g" ;grep -Eih -e "^${sel%${tail:0:1}}${tail: -1}\s" -e "^[ぁ-ん]+${tail: -1}\s.*/${sel%${tail:0:1}}(;.+?)?/" '.a:skk_jisyo.' |sed -r "s@(${tail: -1}\s|;[^/]+)?/@${tail:0:1}/@g") | awk '''.a:offset.'<NR''| tr -d "\n" |head -c-1 |awk -v "RS=/" ''NR<='.strlen(indexes).'{printf("%s:%s ",substr("'.indexes.'",NR,1),$0)}''')
  if empty(entries) | echo '再変換:候補無し' | return | endif
  echo entries
  let c = getchar(0) | while c ==# '\<CursorHold>' | sleep 51m| let c = getchar(0) | endwhile
  if empty(nr2char(c)) |redraw| echo ''| return| endif  " Leftだとc=<80>klでascii=''
  if 9 == c | redraw| call Saihenkan(a:offset +1, a:skk_jisyo)| return| endif  " TABで次の見出し行へ
  " let @z = system('awk -F: -v RS=" " ''$1=="'.nr2char(c).'"{printf("%s",$2)}'' ', entries) " スペースの有る候補がダメ
  let @z = system('grep -oP "(?<='.nr2char(c).':).*?(?=\s(.:|$))"| tr -d "\n"', entries)  " grepだと前後に改行が付く(bash内では付かない？)
  redraw| echo @z
  if !empty(@z)
    silent normal! gv"zp
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
