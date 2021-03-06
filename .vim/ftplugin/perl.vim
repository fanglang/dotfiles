" Vim filetype plugin file
"
"   Language :  Perl
"     Plugin :  perl-support.vim
" Maintainer :  Fritz Mehner <mehner@fh-swf.de>
"   Revision :  $Id: perl.vim,v 1.35 2008/11/23 12:35:45 mehner Exp $
"
" ----------------------------------------------------------------------------
"
" Only do this when not done yet for this buffer
" 
if exists("b:did_PERL_ftplugin")
  finish
endif
let b:did_PERL_ftplugin = 1
"
let s:UNIX	= has("unix") || has("macunix") || has("win32unix")
let s:MSWIN = has("win16") || has("win32")   || has("win64")    || has("win95")
"
" ---------- tabulator / shiftwidth ------------------------------------------
"  Set tabulator and shift width to 4 conforming to the Perl Style Guide.
"  Uncomment the next two lines to force these settings for all files with
"  filetype 'perl' .
"  
setlocal  tabstop=4
setlocal  shiftwidth=4
"
" ---------- Add ':' to the keyword characters -------------------------------
"            Tokens like 'File::Find' are recognized as 
"            one keyword
" 
setlocal iskeyword+=:
"
" ---------- Do we have a mapleader other than '\' ? ------------
"
if exists("g:Perl_MapLeader")
	let maplocalleader	= g:Perl_MapLeader
endif    
"
" ---------- Perl dictionary -------------------------------------------------
" This will enable keyword completion for Perl
" using Vim's dictionary feature |i_CTRL-X_CTRL-K|.
"
if exists("g:Perl_Dictionary_File")
    silent! exec 'setlocal dictionary+='.g:Perl_Dictionary_File
endif    
"
" ---------- Brace handling --------------------------------------------------
"  
let s:Perl_BraceOnNewLine          = "no"
if exists('g:Perl_BraceOnNewLine')
  let s:Perl_BraceOnNewLine=g:Perl_BraceOnNewLine
endif
"
command! -nargs=? CriticOptions					call Perl_PerlCriticOptions  (<f-args>)
command! -nargs=1 CriticSeverity				call Perl_PerlCriticSeverity (<f-args>)
command! -nargs=1 CriticVerbosity				call Perl_PerlCriticVerbosity(<f-args>)
command! -nargs=1 RegexSubstitutions		call Perl_PerlRegexSubstitutions(<f-args>)
"
"command! -nargs=1 RegexCodeEvaluation		call Perl_RegexCodeEvaluation(<f-args>)
"
" ---------- Key mappings : function keys ------------------------------------
"
"   Ctrl-F9   run script
"    Alt-F9   run syntax check
"  Shift-F9   set command line arguments
"  Shift-F1   read Perl documentation
" Vim (non-GUI) : shifted keys are mapped to their unshifted key !!!
" 
if has("gui_running")
  "
   map    <buffer>  <silent>  <A-F9>             :call Perl_SyntaxCheck()<CR>:redraw!<CR>:call Perl_SyntaxCheckMsg()<CR>
  imap    <buffer>  <silent>  <A-F9>        <C-C>:call Perl_SyntaxCheck()<CR>:redraw!<CR>:call Perl_SyntaxCheckMsg()<CR>
  "
   map    <buffer>  <silent>  <C-F9>             :call Perl_Run()<CR>
  imap    <buffer>  <silent>  <C-F9>        <C-C>:call Perl_Run()<CR>
  "
   map    <buffer>  <silent>  <S-F9>             :call Perl_Arguments()<CR>
  imap    <buffer>  <silent>  <S-F9>        <C-C>:call Perl_Arguments()<CR>
  "
   map    <buffer>  <silent>  <S-F1>             :call Perl_perldoc()<CR><CR>
  imap    <buffer>  <silent>  <S-F1>        <C-C>:call Perl_perldoc()<CR><CR>
endif
"
"-------------------------------------------------------------------------------
"   Key mappings for menu entries
"   The mappings can be switched on and off by g:Perl_NoKeyMappings
"-------------------------------------------------------------------------------
"
if !exists("g:Perl_NoKeyMappings") || ( exists("g:Perl_NoKeyMappings") && g:Perl_NoKeyMappings!=1 )
	"
	" ----------------------------------------------------------------------------
	" Comments
	" ----------------------------------------------------------------------------
	"
	inoremap    <buffer>  <silent>  <LocalLeader>cj    <C-C>:call Perl_AlignLineEndComm("a")<CR>a
	inoremap    <buffer>  <silent>  <LocalLeader>cl    <C-C>:call Perl_LineEndComment("")<CR>A
	nnoremap    <buffer>  <silent>  <LocalLeader>cj         :call Perl_AlignLineEndComm("a")<CR>
	nnoremap    <buffer>  <silent>  <LocalLeader>cl         :call Perl_LineEndComment("")<CR>A
	vnoremap    <buffer>  <silent>  <LocalLeader>cj    <C-C>:call Perl_AlignLineEndComm("v")<CR>
	vnoremap    <buffer>  <silent>  <LocalLeader>cl    <C-C>:call Perl_MultiLineEndComments()<CR>A

	nnoremap    <buffer>  <silent>  <LocalLeader>cs         :call Perl_GetLineEndCommCol()<CR>

	nnoremap    <buffer>  <silent>  <LocalLeader>cfr        :call Perl_CommentTemplates('frame')<CR>
	nnoremap    <buffer>  <silent>  <LocalLeader>cfu        :call Perl_CommentTemplates('function')<CR>
	nnoremap    <buffer>  <silent>  <LocalLeader>cm         :call Perl_CommentTemplates('method')<CR>
	nnoremap    <buffer>  <silent>  <LocalLeader>ch         :call Perl_CommentTemplates('header')<CR>
	nnoremap    <buffer>  <silent>  <LocalLeader>ce         :call Perl_CommentTemplates('module')<CR>
	nnoremap    <buffer>  <silent>  <LocalLeader>ca         :call Perl_CommentTemplates('test')<CR>

	inoremap    <buffer>  <silent>  <LocalLeader>cfr   <C-C>:call Perl_CommentTemplates('frame')<CR>
	inoremap    <buffer>  <silent>  <LocalLeader>cfu   <C-C>:call Perl_CommentTemplates('function')<CR>
	inoremap    <buffer>  <silent>  <LocalLeader>cm    <C-C>:call Perl_CommentTemplates('method')<CR>
	inoremap    <buffer>  <silent>  <LocalLeader>ch    <C-C>:call Perl_CommentTemplates('header')<CR>
	inoremap    <buffer>  <silent>  <LocalLeader>ce    <C-C>:call Perl_CommentTemplates('module')<CR>
	inoremap    <buffer>  <silent>  <LocalLeader>ca    <C-C>:call Perl_CommentTemplates('test')<CR>

	nnoremap    <buffer>  <silent>  <LocalLeader>ckb        :call Perl_CommentClassified("BUG")       <CR>A
	nnoremap    <buffer>  <silent>  <LocalLeader>ckt        :call Perl_CommentClassified("TODO")      <CR>A
	nnoremap    <buffer>  <silent>  <LocalLeader>ckr        :call Perl_CommentClassified("TRICKY")    <CR>A
	nnoremap    <buffer>  <silent>  <LocalLeader>ckw        :call Perl_CommentClassified("WARNING")   <CR>A
	nnoremap    <buffer>  <silent>  <LocalLeader>cko        :call Perl_CommentClassified("WORKAROUND")<CR>A
	nnoremap    <buffer>  <silent>  <LocalLeader>ckn        :call Perl_CommentClassified("")          <CR>3F:i
                                                
	inoremap    <buffer>  <silent>  <LocalLeader>ckb   <C-C>:call Perl_CommentClassified("BUG")       <CR>A
	inoremap    <buffer>  <silent>  <LocalLeader>ckt   <C-C>:call Perl_CommentClassified("TODO")      <CR>A
	inoremap    <buffer>  <silent>  <LocalLeader>ckr   <C-C>:call Perl_CommentClassified("TRICKY")    <CR>A
	inoremap    <buffer>  <silent>  <LocalLeader>ckw   <C-C>:call Perl_CommentClassified("WARNING")   <CR>A
	inoremap    <buffer>  <silent>  <LocalLeader>cko   <C-C>:call Perl_CommentClassified("WORKAROUND")<CR>A
	inoremap    <buffer>  <silent>  <LocalLeader>ckn   <C-C>:call Perl_CommentClassified("")          <CR>3F:i

	nnoremap    <buffer>  <silent>  <LocalLeader>cc         :call Perl_CommentToggle()<CR>j
	vnoremap    <buffer>  <silent>  <LocalLeader>cc    <C-C>:'<,'>call Perl_CommentToggle()<CR>j

	nnoremap    <buffer>  <silent>  <LocalLeader>cd    a<C-R>=strftime("%x")<CR>
	nnoremap    <buffer>  <silent>  <LocalLeader>ct    a<C-R>=strftime("%x %X %Z")<CR>
	inoremap    <buffer>  <silent>  <LocalLeader>cd    <C-R>=strftime("%x")<CR>
	inoremap    <buffer>  <silent>  <LocalLeader>ct    <C-R>=strftime("%x %X %Z")<CR>

	nnoremap    <buffer>  <silent>  <LocalLeader>cv         :call Perl_CommentVimModeline()<CR>
	nnoremap    <buffer>  <silent>  <LocalLeader>cb         :call Perl_CommentBlock("a")<CR>
	vnoremap    <buffer>  <silent>  <LocalLeader>cb    <C-C>:call Perl_CommentBlock("v")<CR>
	nnoremap    <buffer>  <silent>  <LocalLeader>cn         :call Perl_UncommentBlock()<CR>
	"
	" ----------------------------------------------------------------------------
	" Statements
	" ----------------------------------------------------------------------------
	"
	nnoremap    <buffer>  <silent>  <LocalLeader>sd              :call Perl_DoWhile("a")<CR>f(la
	nnoremap    <buffer>  <silent>  <LocalLeader>sf              :call Perl_StatBlock( "a", "for ( my $; ;  ) {\n}","" )<CR>f$a
	nnoremap    <buffer>  <silent>  <LocalLeader>sfe             :call Perl_StatBlock( "a", "foreach my $ (  ) {\n}", "" )<CR>f$a
	nnoremap    <buffer>  <silent>  <LocalLeader>sei             :call Perl_StatBlock( "a", "elsif (  ) {\n}", "" )<CR>f(la
	nnoremap    <buffer>  <silent>  <LocalLeader>si              :call Perl_StatBlock( "a", "if (  ) {\n}", "" )<CR>f(la
	nnoremap    <buffer>  <silent>  <LocalLeader>sie             :call Perl_StatBlock( "a", "if (  ) {\n}\nelse {\n}", "" )<CR>f(la
	nnoremap    <buffer>  <silent>  <LocalLeader>su              :call Perl_StatBlock( "a", "unless (  ) {\n}", "" )<CR>f(la
	nnoremap    <buffer>  <silent>  <LocalLeader>sue             :call Perl_StatBlock( "a", "unless (  ) {\n}\nelse {\n}", "" )<CR>f(la
	nnoremap    <buffer>  <silent>  <LocalLeader>st              :call Perl_StatBlock( "a", "until (  ) {\n}", "" )<CR>f(la
	nnoremap    <buffer>  <silent>  <LocalLeader>sw              :call Perl_StatBlock( "a", "while (  ) {\n}", "" )<CR>f(la
	nnoremap    <buffer>  <silent>  <LocalLeader>s{              :call Perl_Block("a")<CR>o

	vnoremap    <buffer>  <silent>  <LocalLeader>sd    <C-C>:call Perl_DoWhile("v")<CR>f(la
	vnoremap    <buffer>  <silent>  <LocalLeader>sf    <C-C>:call Perl_StatBlock( "v", "for ( my $; ;  ) {", "}" )<CR>f$a
	vnoremap    <buffer>  <silent>  <LocalLeader>sfe   <C-C>:call Perl_StatBlock( "v", "foreach my $ (  ) {", "}" )<CR>f$a
	vnoremap    <buffer>  <silent>  <LocalLeader>sei   <C-C>:call Perl_StatBlock( "v", "elsif (  ) {", "}" )<CR>f(la
	vnoremap    <buffer>  <silent>  <LocalLeader>si    <C-C>:call Perl_StatBlock( "v", "if (  ) {", "}" )<CR>f(la
	vnoremap    <buffer>  <silent>  <LocalLeader>sie   <C-C>:call Perl_StatBlock( "v", "if (  ) {", "}\nelse {\n}" )<CR>f(la
	vnoremap    <buffer>  <silent>  <LocalLeader>su    <C-C>:call Perl_StatBlock( "v", "unless (  ) {", "}" )<CR>f(la
	vnoremap    <buffer>  <silent>  <LocalLeader>sue   <C-C>:call Perl_StatBlock( "v", "unless (  ) {", "}\nelse {\n}" )<CR>f(la
	vnoremap    <buffer>  <silent>  <LocalLeader>st    <C-C>:call Perl_StatBlock( "v", "until (  ) {", "}" )<CR>f(la
	vnoremap    <buffer>  <silent>  <LocalLeader>sw    <C-C>:call Perl_StatBlock( "v", "while (  ) {", "}" )<CR>f(la
	vnoremap    <buffer>  <silent>  <LocalLeader>s{    <C-C>:call Perl_Block("v")<CR>

	inoremap    <buffer>  <silent>  <LocalLeader>sd    <C-C>:call Perl_DoWhile("a")<CR>f(la
	inoremap    <buffer>  <silent>  <LocalLeader>sf    <C-C>:call Perl_StatBlock( "a", "for ( my $; ;  ) {\n}","" )<CR>f$a
	inoremap    <buffer>  <silent>  <LocalLeader>sfe   <C-C>:call Perl_StatBlock( "a", "foreach my $ (  ) {\n}", "" )<CR>f$a
	inoremap    <buffer>  <silent>  <LocalLeader>sei   <C-C>:call Perl_StatBlock( "a", "elsif (  ) {\n}", "" )<CR>f(la
	inoremap    <buffer>  <silent>  <LocalLeader>si    <C-C>:call Perl_StatBlock( "a", "if (  ) {\n}", "" )<CR>f(la
	inoremap    <buffer>  <silent>  <LocalLeader>sie   <C-C>:call Perl_StatBlock( "a", "if (  ) {\n}\nelse {\n}", "" )<CR>f(la
	inoremap    <buffer>  <silent>  <LocalLeader>su    <C-C>:call Perl_StatBlock( "a", "unless (  ) {\n}", "" )<CR>f(la
	inoremap    <buffer>  <silent>  <LocalLeader>sue   <C-C>:call Perl_StatBlock( "a", "unless (  ) {\n}\nelse {\n}", "" )<CR>f(la
	inoremap    <buffer>  <silent>  <LocalLeader>st    <C-C>:call Perl_StatBlock( "a", "until (  ) {\n}", "" )<CR>f(la
	inoremap    <buffer>  <silent>  <LocalLeader>sw    <C-C>:call Perl_StatBlock( "a", "while (  ) {\n}", "" )<CR>f(la
	"
	nnoremap    <buffer>  <silent>  <LocalLeader>nr    <C-C>:call Perl_CodeSnippet("r")<CR>
	nnoremap    <buffer>  <silent>  <LocalLeader>nw    <C-C>:call Perl_CodeSnippet("w")<CR>
	vnoremap    <buffer>  <silent>  <LocalLeader>nw    <C-C>:call Perl_CodeSnippet("wv")<CR>
	nnoremap    <buffer>  <silent>  <LocalLeader>ne    <C-C>:call Perl_CodeSnippet("e")<CR>
	"
	" ----------------------------------------------------------------------------
	" Idioms
	" ----------------------------------------------------------------------------
	"	
	nnoremap    <buffer>  <silent>  <LocalLeader>$    o<C-C>:call Perl_Idiom(  '\$', 'my<Tab>$;',                       '$' )<CR>a
	nnoremap    <buffer>  <silent>  <LocalLeader>$=   o<C-C>:call Perl_Idiom( '\$=', 'my<Tab>$<Tab>= ;',                '$' )<CR>a
	nnoremap    <buffer>  <silent>  <LocalLeader>$$   o<C-C>:call Perl_Idiom( '\$$', 'my<Tab>( $, $ );',                '$' )<CR>a
	nnoremap    <buffer>  <silent>  <LocalLeader>@    o<C-C>:call Perl_Idiom(  '\@', 'my<Tab>@;',                       '@' )<CR>a
	nnoremap    <buffer>  <silent>  <LocalLeader>@=   o<C-C>:call Perl_Idiom( '\@=', 'my<Tab>@<Tab>= ( , ,  );',        '@' )<CR>a
	nnoremap    <buffer>  <silent>  <LocalLeader>%    o<C-C>:call Perl_Idiom(  '\%', 'my<Tab>%;',                       '%' )<CR>a
	nnoremap    <buffer>  <silent>  <LocalLeader>%=   o<C-C>:call Perl_Idiom( '\%=', 'my<Tab>%<Tab>= (  => ,  => , );', '%' )<CR>a
	"	
	inoremap    <buffer>  <silent>  <LocalLeader>$    <C-C>:call Perl_Idiom(  '\$', 'my<Tab>$;',                       '$' )<CR>a
	inoremap    <buffer>  <silent>  <LocalLeader>$=   <C-C>:call Perl_Idiom( '\$=', 'my<Tab>$<Tab>= ;',                '$' )<CR>a
	inoremap    <buffer>  <silent>  <LocalLeader>$$   <C-C>:call Perl_Idiom( '\$$', 'my<Tab>( $, $ );',                '$' )<CR>a
	inoremap    <buffer>  <silent>  <LocalLeader>@    <C-C>:call Perl_Idiom(  '\@', 'my<Tab>@;',                       '@' )<CR>a
	inoremap    <buffer>  <silent>  <LocalLeader>@=   <C-C>:call Perl_Idiom( '\@=', 'my<Tab>@<Tab>= ( , ,  );',        '@' )<CR>a
	inoremap    <buffer>  <silent>  <LocalLeader>%    <C-C>:call Perl_Idiom(  '\%', 'my<Tab>%;',                       '%' )<CR>a
	inoremap    <buffer>  <silent>  <LocalLeader>%=   <C-C>:call Perl_Idiom( '\%=', 'my<Tab>%<Tab>= (  => ,  => , );', '%' )<CR>a
	"
	nnoremap    <buffer>  <silent>  <LocalLeader>ir    omy<Tab>$rgx_<Tab>= q//;<Esc>F_a
	inoremap    <buffer>  <silent>  <LocalLeader>ir     my<Tab>$rgx_<Tab>= q//;<Esc>F_a

	if exists("g:Perl_PBP") && g:Perl_PBP == "yes"
		nnoremap    <buffer>  <silent>  <LocalLeader>im    a$ =~ m{}xm<Esc>F$a
		nnoremap    <buffer>  <silent>  <LocalLeader>is    a$ =~ s{}{}xm<Esc>F$a
		nnoremap    <buffer>  <silent>  <LocalLeader>it    a$ =~ tr{}{}xm<Esc>F$a
		"
		inoremap    <buffer>  <silent>  <LocalLeader>im    $ =~ m{}xm<Esc>F$a
		inoremap    <buffer>  <silent>  <LocalLeader>is    $ =~ s{}{}xm<Esc>F$a
		inoremap    <buffer>  <silent>  <LocalLeader>it    $ =~ tr{}{}xm<Esc>F$a
	else
		nnoremap    <buffer>  <silent>  <LocalLeader>im    a$ =~ m//<Esc>F$a
		nnoremap    <buffer>  <silent>  <LocalLeader>is    a$ =~ s///<Esc>F$a
		nnoremap    <buffer>  <silent>  <LocalLeader>it    a$ =~ tr///<Esc>F$a
		"
		inoremap    <buffer>  <silent>  <LocalLeader>im    $ =~ m//<Esc>F$a
		inoremap    <buffer>  <silent>  <LocalLeader>is    $ =~ s///<Esc>F$a
		inoremap    <buffer>  <silent>  <LocalLeader>it    $ =~ tr///<Esc>F$a
	endif
	"
	nnoremap    <buffer>  <silent>  <LocalLeader>ip    aprint "\n";<Left><Left><Left><Left>
	inoremap    <buffer>  <silent>  <LocalLeader>ip     print "\n";<Left><Left><Left><Left>
	"
	inoremap    <buffer>  <silent>  <LocalLeader>ii    <C-C>:call Perl_OpenInputFile("a")<CR>a
	inoremap    <buffer>  <silent>  <LocalLeader>io    <C-C>:call Perl_OpenOutputFile("a")<CR>a
	inoremap    <buffer>  <silent>  <LocalLeader>ipi   <C-C>:call Perl_OpenPipe("a")<CR>a
	inoremap    <buffer>  <silent>  <LocalLeader>isu   <C-C>:call Perl_Subroutine("a")<CR>A
	nnoremap    <buffer>  <silent>  <LocalLeader>ii         :call Perl_OpenInputFile("a")<CR>a
	nnoremap    <buffer>  <silent>  <LocalLeader>io         :call Perl_OpenOutputFile("a")<CR>a
	nnoremap    <buffer>  <silent>  <LocalLeader>ipi        :call Perl_OpenPipe("a")<CR>a
	nnoremap    <buffer>  <silent>  <LocalLeader>isu        :call Perl_Subroutine("a")<CR>A
	vnoremap    <buffer>  <silent>  <LocalLeader>ii    <C-C>:call Perl_OpenInputFile("v")<CR>a
	vnoremap    <buffer>  <silent>  <LocalLeader>io    <C-C>:call Perl_OpenOutputFile("v")<CR>a
	vnoremap    <buffer>  <silent>  <LocalLeader>ipi   <C-C>:call Perl_OpenPipe("v")<CR>a
	vnoremap    <buffer>  <silent>  <LocalLeader>isu   <C-C>:call Perl_Subroutine("v")<CR>f(a
	"
	" ----------------------------------------------------------------------------
	" Regex
	" ----------------------------------------------------------------------------
	"
	nnoremap    <buffer>  <silent>  <LocalLeader>xr        :call Perl_RegexPick( "regexp", "n" )<CR>j
	nnoremap    <buffer>  <silent>  <LocalLeader>xs        :call Perl_RegexPick( "string", "n" )<CR>j
	nnoremap    <buffer>  <silent>  <LocalLeader>xf        :call Perl_RegexPickFlag( "n" )<CR>
	vnoremap    <buffer>  <silent>  <LocalLeader>xr   <C-C>:call Perl_RegexPick( "regexp", "v" )<CR>'>j
	vnoremap    <buffer>  <silent>  <LocalLeader>xs   <C-C>:call Perl_RegexPick( "string", "v" )<CR>'>j
	vnoremap    <buffer>  <silent>  <LocalLeader>xf   <C-C>:call Perl_RegexPickFlag( "v" )<CR>'>j
	nnoremap    <buffer>  <silent>  <LocalLeader>xm        :call Perl_RegexVisualize( )<CR>
	nnoremap    <buffer>  <silent>  <LocalLeader>xe        :call Perl_RegexExplain( "n" )<CR>
	vnoremap    <buffer>  <silent>  <LocalLeader>xe   <C-C>:call Perl_RegexExplain( "v" )<CR>
	"
	" ----------------------------------------------------------------------------
	" POSIX character classes
	" ----------------------------------------------------------------------------
	"
	nnoremap    <buffer>  <silent>  <LocalLeader>pa    a[:alnum:]<Esc>
	nnoremap    <buffer>  <silent>  <LocalLeader>ph    a[:alpha:]<Esc>
	nnoremap    <buffer>  <silent>  <LocalLeader>pi    a[:ascii:]<Esc>
	nnoremap    <buffer>  <silent>  <LocalLeader>pb    a[:blank:]<Esc>
	nnoremap    <buffer>  <silent>  <LocalLeader>pc    a[:cntrl:]<Esc>
	nnoremap    <buffer>  <silent>  <LocalLeader>pd    a[:digit:]<Esc>
	nnoremap    <buffer>  <silent>  <LocalLeader>pg    a[:graph:]<Esc>
	nnoremap    <buffer>  <silent>  <LocalLeader>pl    a[:lower:]<Esc>
	nnoremap    <buffer>  <silent>  <LocalLeader>pp    a[:print:]<Esc>
	nnoremap    <buffer>  <silent>  <LocalLeader>pn    a[:punct:]<Esc>
	nnoremap    <buffer>  <silent>  <LocalLeader>ps    a[:space:]<Esc>
	nnoremap    <buffer>  <silent>  <LocalLeader>pu    a[:upper:]<Esc>
	nnoremap    <buffer>  <silent>  <LocalLeader>pw    a[:word:]<Esc>
	nnoremap    <buffer>  <silent>  <LocalLeader>px    a[:xdigit:]<Esc>
	"
	inoremap    <buffer>  <silent>  <LocalLeader>pa    [:alnum:]
	inoremap    <buffer>  <silent>  <LocalLeader>ph    [:alpha:]
	inoremap    <buffer>  <silent>  <LocalLeader>pi    [:ascii:]
	inoremap    <buffer>  <silent>  <LocalLeader>pb    [:blank:]
	inoremap    <buffer>  <silent>  <LocalLeader>pc    [:cntrl:]
	inoremap    <buffer>  <silent>  <LocalLeader>pd    [:digit:]
	inoremap    <buffer>  <silent>  <LocalLeader>pg    [:graph:]
	inoremap    <buffer>  <silent>  <LocalLeader>pl    [:lower:]
	inoremap    <buffer>  <silent>  <LocalLeader>pp    [:print:]
	inoremap    <buffer>  <silent>  <LocalLeader>pn    [:punct:]
	inoremap    <buffer>  <silent>  <LocalLeader>ps    [:space:]
	inoremap    <buffer>  <silent>  <LocalLeader>pu    [:upper:]
	inoremap    <buffer>  <silent>  <LocalLeader>pw    [:word:]
	inoremap    <buffer>  <silent>  <LocalLeader>px    [:xdigit:]
	"
	" ----------------------------------------------------------------------------
	" Run
	" ----------------------------------------------------------------------------
	"
	 noremap    <buffer>  <silent>  <LocalLeader>rr         :call Perl_Run()<CR>
	 noremap    <buffer>  <silent>  <LocalLeader>rs         :call Perl_SyntaxCheck()<CR>:redraw!<CR>:call Perl_SyntaxCheckMsg()<CR>
	 noremap    <buffer>  <silent>  <LocalLeader>ra         :call Perl_Arguments()<CR>
	 noremap    <buffer>  <silent>  <LocalLeader>rw         :call Perl_PerlSwitches()<CR>
	inoremap    <buffer>  <silent>  <LocalLeader>rr    <C-C>:call Perl_Run()<CR>
	inoremap    <buffer>  <silent>  <LocalLeader>rs    <C-C>:call Perl_SyntaxCheck()<CR>:redraw!<CR>:call Perl_SyntaxCheckMsg()<CR>
	inoremap    <buffer>  <silent>  <LocalLeader>ra    <C-C>:call Perl_Arguments()<CR>
	inoremap    <buffer>  <silent>  <LocalLeader>rw    <C-C>:call Perl_PerlSwitches()<CR>
	"
	if has("gui_running")
		 noremap    <buffer>  <silent>  <LocalLeader>rd         :call Perl_Debugger()<CR>
		 noremap    <buffer>  <silent>    <F9>             :call Perl_Debugger()<CR>
		inoremap    <buffer>  <silent>    <F9>        <C-C>:call Perl_Debugger()<CR>
	else
		 noremap    <buffer>  <silent>  <LocalLeader>rd         :call Perl_Debugger()<CR>:redraw!<CR>
		 noremap    <buffer>  <silent>    <F9>             :call Perl_Debugger()<CR>:redraw!<CR>
		inoremap    <buffer>  <silent>    <F9>        <C-C>:call Perl_Debugger()<CR>:redraw!<CR>
	endif
	"
	if s:UNIX
		 noremap    <buffer>  <silent>  <LocalLeader>re         :call Perl_MakeScriptExecutable()<CR>
		inoremap    <buffer>  <silent>  <LocalLeader>re    <C-C>:call Perl_MakeScriptExecutable()<CR>
	endif
	"
	 map    <buffer>  <silent>  <LocalLeader>rp         :call Perl_perldoc()<CR>
	 map    <buffer>  <silent>  <LocalLeader>h          :call Perl_perldoc()<CR>
	"
	 map    <buffer>  <silent>  <LocalLeader>ri         :call Perl_perldoc_show_module_list()<CR>
	 map    <buffer>  <silent>  <LocalLeader>rg         :call Perl_perldoc_generate_module_list()<CR>:redraw!<CR>
	"
	 map    <buffer>  <silent>  <LocalLeader>ry         :call Perl_Perltidy("n")<CR>
	vmap    <buffer>  <silent>  <LocalLeader>ry    <C-C>:call Perl_Perltidy("v")<CR>
	"
	 map    <buffer>  <silent>  <LocalLeader>rm         :call Perl_Smallprof()<CR>
	 map    <buffer>  <silent>  <LocalLeader>rc         :call Perl_Perlcritic()<CR>:redraw<CR>:call Perl_PerlcriticMsg()<CR>
	 map    <buffer>  <silent>  <LocalLeader>rt         :call Perl_SaveWithTimestamp()<CR>
	 map    <buffer>  <silent>  <LocalLeader>rh         :call Perl_Hardcopy("n")<CR>
	vmap    <buffer>  <silent>  <LocalLeader>rh    <C-C>:call Perl_Hardcopy("v")<CR>
	"
	 map    <buffer>  <silent>  <LocalLeader>rk    :call Perl_Settings()<CR>
	if has("gui_running") && s:UNIX
	 	 map    <buffer>  <silent>  <LocalLeader>rx    :call Perl_XtermSize()<CR>
	endif
	"
	 map    <buffer>  <silent>  <LocalLeader>ro         :call Perl_Toggle_Gvim_Xterm()<CR>
	imap    <buffer>  <silent>  <LocalLeader>ro    <C-C>:call Perl_Toggle_Gvim_Xterm()<CR>
	"
	"
endif

" ----------------------------------------------------------------------------
"  Generate (possibly exuberant) Ctags style tags for Perl sourcecode.
"  Controlled by g:Perl_PerlTags, enabled by default.
" ----------------------------------------------------------------------------
if has('perl')
	if g:Perl_PerlTags == "enabled"
		"
		if s:UNIX
			exe "source ".g:Perl_PluginDir."/perl-support/scripts/perltags.vim"
		endif
		"
		if s:MSWIN
			source $VIM/vimfiles/perl-support/scripts/perltags.vim
		endif
	endif
end
"
" ----------------------------------------------------------------------------
