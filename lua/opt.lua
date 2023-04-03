-- setting
--色設定
vim.opt.termguicolors = true

-- ファイル処理
--文字コードをUFT-8に設定
vim.opt.fileencoding = 'utf-8'
vim.opt.fileencodings = 'utf-8,iso-2022-jp,sjis,cp932,euc-jp,utf-8'
vim.opt.fileformats = 'unix'
-- バックアップファイルを作らない
vim.opt.backup = false
vim.opt.swapfile = false
-- 入力中のコマンドをステータスに表示する
vim.opt.showcmd = true
--行末改行
vim.opt.fixeol = false

-- 表示系
-- 行番号を表示
vim.opt.number = true
-- 行末の1文字先までカーソルを移動できるように
vim.opt.virtualedit = 'onemore'
-- インデントはスマートインデント
-- ビープ音を可視化
vim.opt.visualbell = true
-- 括弧入力時の対応する括弧を表示
vim.opt.showmatch = true
-- ステータスラインを常に表示
vim.opt.laststatus = 2
vim.opt.statusline = "%F%m%r%h%w%=[%{&ff}][%{&fileencoding}][%Y:%{&buftype}][ASCII=%03.3b][HEX=%02.2B][%l,%v][%p%%:%L]"
-- 不可視文字を可視化(タブが「▸-」と表示される)
vim.opt.list = true
vim.opt.listchars = 'tab:»·,trail:-,eol:↲,extends:»,precedes:«,nbsp:%'

-- 検索系
-- 検索文字列が小文字の場合は大文字小文字を区別なく検索する
vim.opt.ignorecase = true
-- 検索文字列に大文字が含まれている場合は区別して検索する
vim.opt.smartcase = true
-- 検索文字列入力時に順次対象文字列にヒットさせる
vim.opt.incsearch = true
-- 検索時に最後まで行ったら最初に戻る
vim.opt.wrapscan = true
-- 検索語をハイライト表示
vim.opt.hlsearch = true

-- タブ/インデント
-- 行頭以外のTab文字の表示幅（スペースいくつ分）
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
-- インデント
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.cinoptions:append{':0'}
-- 切り替えコマンド
vim.api.nvim_create_user_command('SetTabKernel',
function(_)
    vim.opt.tabstop = 8
    vim.opt.shiftwidth = 8
    vim.opt.softtabstop = 8
    vim.opt.expandtab = false
end , { nargs = 0})

vim.api.nvim_create_user_command('SetTabDefault',
function(_)
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.softtabstop = 4
    vim.opt.expandtab = true
end , { nargs = 0})

-- その他
-- カウントアップ
vim.opt.nrformats = 'bin,hex,alpha'

-- フォーマッタ
vim.keymap.set({'n'},  'K', ':Man <C-r><C-w><CR>', {})
vim.keymap.set({'v'},  '<C-k>', ':py3f ~/.config/nvim/bin/clang-format.py<CR>', {})
vim.keymap.set({'i'},  '<C-k>', '<C-o>:py3f ~/.config/nvim/bin/clang-format.py<CR>', {})
vim.g.clang_format_path = 'clang-format-15'

---- Leader
vim.g.mapleader = ' '

-- 全角スペース・行末のスペース・タブの可視化
local mygroup = vim.api.nvim_create_augroup('init_opt', { clear = true })
vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
  pattern = '*',
  group = mygroup,
  callback = function()
    vim.api.nvim_set_hl(0, 'UnicodeSpaces', { cterm=underline, underline=true,  fg='#465457', bg='red' })
  end,
})
vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter' }, {
  pattern = '*',
  group = mygroup,
  command = 'match UnicodeSpaces /\\%u180E\\|\\%u2000\\|\\%u2001\\|\\%u2002\\|\\%u2003\\|\\%u2004\\|\\%u2005\\|\\%u2006\\|\\%u2007\\|\\%u2008\\|\\%u2009\\|\\%u200A\\|\\%u2028\\|\\%u2029\\|\\%u202F\\|\\%u205F\\|\\%u3000/'
})

-- grep ロケーションリスト表示
vim.keymap.set({'n'},  '<Leader>ff',
function()
    local cword = vim.fn.expand("<cword>")
    local grep_cmd = 'lexpr system(printf(\'ag -w -s --ignore .repo --ignore .git --ignore tags '..cword..'\')) | lw'
    vim.cmd(grep_cmd)
end, { silent = true })

local function MyMove(opt)
    local cf = vim.fn.expand('%')
    local cp = vim.fn.getpos('.')
    for i, s in ipairs(opt) do
        local cmd = ':silent! '..s
        vim.cmd(cmd)
        local pf = vim.fn.expand('%')
        local pp = vim.fn.getpos('.')
        for ii, ss in ipairs(pp) do
            if ss ~= cp[ii] then
                return
            end
        end
        if cf ~= pf then
            return
        end
    end
end

-- ロケーション、クイックフィックスを良い感じに移動
vim.keymap.set({'v', 'n'},  '<C-n>',
function()
    local qw = vim.fn.getqflist({winid = 0}).winid
    local lw = vim.fn.getloclist(0, {winid = 0}).winid
    if lw ~= 0 then
        MyMove({"laft", "lne"})
    elseif qw ~= 0 then
        MyMove({"caft", "cne"})
    else
        MyMove({"caft", "laft", "cne", "lne"})
    end
end, { })

vim.keymap.set({'v', 'n'},  '<C-p>',
function()
    local qw = vim.fn.getqflist({winid = 0}).winid
    local lw = vim.fn.getloclist(0, {winid = 0}).winid
    if lw ~= 0 then
        MyMove({"lbef", "lpr"})
    elseif qw ~= 0 then
        MyMove({"cbef", "cpr"})
    else
        MyMove({"cbef", "lbef", "cpr", "lpr"})
    end
end, { })

