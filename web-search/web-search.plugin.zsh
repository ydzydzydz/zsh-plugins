# web_search from terminal

function web_search() {
	emulate -L zsh
	
	typeset -A urls
	urls=(
		$ZSH_WEB_SEARCH_ENGINES
		google		"https://www.google.com/search?q="
		bing		"https://www.bing.com/search?q="
		yahoo		"https://search.yahoo.com/search?p="
		duckduckgo	"https://www.duckduckgo.com/?q="
		startpage	"https://www.startpage.com/do/search?q="
		yandex		"https://yandex.ru/yandsearch?text="
		github		"https://github.com/search?q="
		baidu		"https://www.baidu.com/s?wd="
		ecosia		"https://www.ecosia.org/search?q="
		goodreads	"https://www.goodreads.com/search?q="
		qwant		"https://www.qwant.com/?q="
		givero		"https://www.givero.com/search?q="
		stackoverflow	"https://stackoverflow.com/search?q="
		wolframalpha	"https://www.wolframalpha.com/input/?i="
		archive		"https://web.archive.org/web/*/"
		scholar		"https://scholar.google.com/scholar?q="
	)
	
	if [[ -z "$urls[$1]" ]]; then
		echo "Search engine '$1' not supported."
		return 1
	fi

	if [[ $# -gt 1 ]]; then
		for keyword_tmp in ${@[2,-1]}; do
			keyword_tmp=$(urlencode $keyword_tmp)
			if [ -z $keyword ]; then
				keyword=$keyword_tmp
			else
				keyword=$keyword+$keyword_tmp 
			fi
		done
		url="${urls[$1]}${keyword}"
	  	unset keyword_tmp keyword
	else
		url="${(j://:)${(s:/:)urls[$1]}[1,2]}"
	fi

	if [[ "$OSTYPE" =~ linux ]]; then
		if [[ ! $(runlevel) =~ 5 ]]; then
			command -v w3m &> /dev/null && w3m "$url" || echo -e "\033[31mw3m not found \033[0m"
		else
			open_command "$url"
		fi
	else
		open_command "$url"
	fi
}

alias bing='web_search bing'
alias google='web_search google'
alias yahoo='web_search yahoo'
alias ddg='web_search duckduckgo'
alias sp='web_search startpage'
alias yandex='web_search yandex'
alias github='web_search github'
alias baidu='web_search baidu'
alias ecosia='web_search ecosia'
alias goodreads='web_search goodreads'
alias qwant='web_search qwant'
alias givero='web_search givero'
alias stackoverflow='web_search stackoverflow'
alias wolframalpha='web_search wolframalpha'
alias archive='web_search archive'
alias scholar='web_search scholar'

alias wiki='web_search duckduckgo \!w'
alias news='web_search duckduckgo \!n'
alias youtube='web_search duckduckgo \!yt'
alias map='web_search duckduckgo \!m'
alias image='web_search duckduckgo \!i'
alias ducky='web_search duckduckgo \!'

if [[ ${#ZSH_WEB_SEARCH_ENGINES} -gt 0 ]]; then
	typeset -A engines
	engines=($ZSH_WEB_SEARCH_ENGINES)
	for key in ${(k)engines}; do
		alias "$key"="web_search $key"
	done
	unset engines key
fi
